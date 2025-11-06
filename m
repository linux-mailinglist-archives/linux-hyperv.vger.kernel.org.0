Return-Path: <linux-hyperv+bounces-7419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B8C3A312
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D98460B4F
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876D30DD09;
	Thu,  6 Nov 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlEfJF3o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAF2DEA83
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423735; cv=none; b=KDXqrUpvr2OPpoF1OnnFyTTR63MFi1lLy1/UovMwo/VZgnhRhuMrAmKVIpvv0dV/U7fvD5MVanxD+sGMkeBFcbEqqXR9xxGrHkc5dr7Su1eJpo01nYZKGSC2ln7EcZIEiNLEEqdWbEoEhzyrJ8PSK8L6NSg+sroYfuyJovI73lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423735; c=relaxed/simple;
	bh=1DqFSj/S5FdRM8xI1vnmMW27R5cKr38U/BL7DRT8f0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=infK+qXc4sgkA2VxoEJ48aONfIzeQLKibkbCBWc0+6hBNGDYFX4CjPYy4MjcJ7wNAWQ6y7x9KXnkJ7+H4QAczpJNeEf/u7XDPJXZKAZ19RXpjZQi0tc5Dhz5bRW/78s4Yb6xF80HWbZS/mqNgUpfjYHNONir7lu4LHhNU5VvvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlEfJF3o; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55517e74e3so749537a12.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762423733; x=1763028533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5B/ZONU+mx/MPUhZ8D2RqXDgUbTh84Ll8Fc5jTmwlA0=;
        b=mlEfJF3oPxLblRV4lAF2VG3SsP74Gq63409Ip3P24uJlVoujGz4BVdywglFT8UohXt
         sbu6VzHs7luUzp4Z9UC7y8zs3uwB55x8lHpXaMxor1J6qOkHQuDHtJYoO8tPYk0c7ZoW
         fzTsCb1fez042OSglt08WcCx4QKUXRbyk9iwd8sYTcycAoQCrooNnnMBqGUX0qcWcrBa
         Gc9BjVOqMhXXusloJxrcCe4cnNnly4TyN2D6diL3ElnY48QXdC3yBati26R+0sQOnvGS
         rID/KYCjjOKzPIHe/BNq6fsPsP633oVUrTqBptjTfvyCgB1iYXpcFvkAIxQ8dmGSMmnc
         y9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423733; x=1763028533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B/ZONU+mx/MPUhZ8D2RqXDgUbTh84Ll8Fc5jTmwlA0=;
        b=l5FHfZ8g6Gpn7devIkraK93VeFwSVW0uus+UwSZFQOGQfR6D89priVEk29xplN7jMR
         zKoOAhk9uPzJRT6N2XWumCQQ5Nkm5r0a4tjcsd2iHB0lNU5R/EyYB4BoCBSkXvvO09Vv
         A2FxoEBBTHepoQFNuIqTPHGAfub44/MpbGksb7tgya9CJ8nXMfTxz1SB2ucwPr2uJvzA
         FzbR3vHOp+yZprwEwpX9Xb57Yxu1urq0lwdg8zYSRIeu6jcS5G3VuJFaN20zUkSxfaJh
         OVsIKQC8UI7gBST0tRsXM+k9uAPDzSmKB1MrP8DCNRZads5KjUMjsj3KTwPszoy1pJfX
         b/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXME+HTMBYnpVcA90+wN/lFALhMbQD2stRaUgZGR6tIvdFnDL9+9PrHUD/am5sNGio9tgV4cpOBYIowo3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4LIqMPh7bfOcOOSY7fZ1D8J9SSTvuk6hUa1fZ4eOk3KZPiCi
	kMIVfY31toqwguu2aMwSxkTQ+nAKCT0jIAdtJwolQerP11Bt1ysowuvg
X-Gm-Gg: ASbGnctfUl+p5dIOPzdSAcZFVqY9LGgAbRhcfpm4TaloCjfwWjFav92daKUe5Odpgkj
	/cveq/NZTI5qLvjX7nzhBKP0salN4zX9v4DKo5PjzN6m06qTMlO44tCLA2LnkxEt5HunBaXjckh
	X3fxodjTyZwBpCFFuShg7qvDoHqYuGxqp+3comT4qhnm16xN4/worx76fDWeGS7We+1fs9vmykr
	1Z2Xhc/bkhllAoi7oVkfKmIPuSAivznglimc61QIaHkiWSQldaF0ZN7s5AWXqJOMsV9e5x/3gic
	axaL/ZJxTBnkCRR5JG837ocE6no1ms/UYRRiLTliKAfv7VOW/EpfDPgS2tcEyFNsTW1LIDinQeA
	g/Kyim26bFZE1ffXLrg2JUx499ka8+uY84HmzA997fxfdtL6ZRsxLNd77pZ/6PzSamcQL31WOVF
	iu
X-Google-Smtp-Source: AGHT+IGGknNbfaJf1wlwBpbXS9DgfCxm28G8CeSW3otZfXLcPcwJFPQBOKlOcIpLEk4FHszmJ38k6Q==
X-Received: by 2002:a05:6a20:1b10:b0:343:64dc:8d3 with SMTP id adf61e73a8af0-34f866ffce8mr6522570637.31.1762423733294;
        Thu, 06 Nov 2025 02:08:53 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207232sm1855872a12.32.2025.11.06.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:08:52 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Thu, 06 Nov 2025 15:38:41 +0530
Subject: [PATCH v2] net: ethernet: fix uninitialized pointers with free
 attr
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKhzDGkC/52NTQ6CMBBGr0K6dkyL/BhX3sOwKHRKJ4FiprVRC
 Xe3cAR33/sW760iIBMGcStWwZgo0OIzlKdCDE77EYFMZlHKslZK1qAdYoKXJ0+R9ERfNGAZEXS
 MDB4jYHTI+2iNkg1Wur/YVmThk9HS+4g9usyOQlz4c7ST2t+/MkmBAtugvlZ9b9pa3sdZ03Qel
 ll027b9AKkmv87kAAAA
X-Change-ID: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=1DqFSj/S5FdRM8xI1vnmMW27R5cKr38U/BL7DRT8f0g=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ5ite1TzulbSKvft6+c1daVuL3VXO3XN4S+kf7pZ/nF
 mfjf2sdOkpZGMS4GGTFFFkYRaX89DZJTYg7nPQNZg4rE8gQBi5OAZjIVQmG/45tCdELukNbauaV
 zUr0cPrRop6YYxkY0VLG7HF+isKty4wM7Ynayxg0fV5dMYjz6nz+fpVBVJK8j5Xa1BURM+5Nlmp
 jBQA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

net/ethernet doesn't have any bugs related to this as of now,
but it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v2:
- fixed non pointer initialization to NULL
- NOTE: drop v1
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com
---
 drivers/net/ethernet/intel/ice/ice_flow.c       | 5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
 			 struct ice_parser_profile *prof, enum ice_block blk)
 {
 	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
-	struct ice_flow_prof_params *params __free(kfree);
 	u8 fv_words = hw->blk[blk].es.fvw;
 	int status;
 	int i, idx;
 
-	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	struct ice_flow_prof_params *params __free(kfree) =
+		kzalloc(sizeof(*params), GFP_KERNEL);
+
 	if (!params)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..368138715cd55cd1dadc686931cdda51c7a5130d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1012,7 +1012,6 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
  */
 static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 {
-	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
 	struct idpf_vc_xn_params xn_params = {
 		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
 		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
@@ -1023,7 +1022,9 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 	ssize_t reply_sz;
 	int err = 0;
 
-	rcvd_regions = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
+	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree) =
+		kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
+
 	if (!rcvd_regions)
 		return -ENOMEM;
 

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


