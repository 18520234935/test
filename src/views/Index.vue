<template>
  <div class="web">
    <div>
      <span>是否开启图片水印</span>
      <input type="checkbox" v-model="checkStatus" />
    </div>
    <div>
      <span>选择图片：</span>
      <input type="file" @input="sourceImgUp" />
    </div>
    <div>
      <span>选择水印图片：</span>
      <input type="file" @input="watermarkImgUp" />
    </div>
    <button @click="upload">上传文件</button>

    <div>
      <img :src="imgUrl" alt="" />
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data: function () {
    return {
      sourceImg: null,
      watermarkImg: null,
      checkStatus: "",
      imgUrl: "",
    };
  },
  methods: {
    sourceImgUp(e) {
      this.sourceImg = e.target.files[0];
    },
    watermarkImgUp(e) {
      this.watermarkImg = e.target.files[0];
    },
    upload() {
      let param = new FormData();
      param.append("fileData", this.sourceImg);
      param.append("watermark", this.checkStatus);
      let config = {
        headers: { "Content-Type": "multipart/form-data" },
      };
      axios.post("http://127.0.0.1:7001/upload", param, config).then((res) => {
        console.log(res);
        this.imgUrl = res.data.fileUrl;
      });
    },
  },
};
</script>

<style lang="scss" scoped>
div {
  margin: 10px 0;
}
</style>