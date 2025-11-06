Return-Path: <linux-hyperv+bounces-7423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C03C3AC5B
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299D51AA5638
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0673164D4;
	Thu,  6 Nov 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOAX6D83"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BD310650
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430181; cv=none; b=V2Gvy8/3Jskd4QSKNsfVATRepZEU5pOuBTtsbuJN6yLopZwJxt8h9ASaf1QnUcFkfnZjF1SB0ZBRJO5Q43xN9KD2nCInrt2KeFJxwgKxlPoWm7FGPGrtsa+WE4KTo7F3IVRHmTg173VzY5JtW1abyEI3XJAdZ9rwSzzMz+N1X0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430181; c=relaxed/simple;
	bh=F5ah8MsnK3Z9znouBMKy+zHLSoJBwjNa27W+pmH6JFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LjnfLjucEKqQ7BPJfyp4JBgX03ZixwZSvcmck94Npb//SpA1lpN0XjbhDGWTdoEAFb7p6FlBWqlTzUTrqNi2wSQgqK5sYkV2AssQgnX1VNysw54HnZ7WbymzSF/PsYeCefbF/RY3REKoDRB4HnPmBNPx5i0H2v2ps6YDsI7aOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOAX6D83; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7afd7789ccdso431212b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762430179; x=1763034979; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNpcXHGc/4OOByDk3Xi+rklLjzHFy8Vk5vFGZ7I57lE=;
        b=dOAX6D833vsJj457zNJu0vLzK6iIzbzazjs6i30oiu6LagC9kcB5mOjq6+prtGzY2x
         ELku25DIxYDXi0vHZduZsz2tbEct4gYpppv3EAhpvTBCfE+Rt+qwuQvW7kfusC5O8T0S
         OFcepC1TW0V4epixtjgBnPkXzgx73pt7bpwvQ0OaIQ9ixwNDcqF7b+i7l7XF/GCUflyN
         rjVVJmrS9ImWpMK9YCfQZ55Kh4BGE3AeX2Mtl07dQ6N9SO96pXzA7WQwaxhoisJS7HiA
         jXibqUsz/8fDQfnRahsesqH6WqR90E8J2G70IB3Y3Zter8I8MO4mvYYMdfIECKdJFhEJ
         1Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430179; x=1763034979;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNpcXHGc/4OOByDk3Xi+rklLjzHFy8Vk5vFGZ7I57lE=;
        b=ryMyS6A5ccY1pdvm+zuanW6ejHJnHVmDDYrtgedXY16FKbMP6zVBwjPVIpF9QKHVWd
         aWHW4mzxDYeLjXQYWKozEBDSQnqJcO0z3PZLXj9wc7KCRrCNfseuavCKC7BLjFLs1Fyp
         a2E839G4PvabfFad8inu0VtcdadSwReswSRWKAAeRCWAqwh5Q9WNgWof743VlgHI9onv
         5q/fII7Z1qQMVz3MDA05CwjLjxwhyXRxHMT98ZYTx2xttKbC4R3h0PwFx6gsu347zoaL
         Vs6vPwRXx2ACL5nUSMhEfoQ2dsWtYFrdrFlmLJW5WHlJ4oYtk/vklNKcpmeHErcUJ8lz
         WcIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5aiigpdTjjICnDNdjpqicttn71/8EH+qYV5wrUmARVsTcJ8M+Bkf+jKyQO+T+fZn3w7fw5MhrQyyYNIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKeqBAdOKqzrwmXQx6/7GvU8rg41RP+gzLOowSakSOCAQJ0Mx
	B6HqQQEBwpqm+gt1yi+TLunCGTPwxkPiWKiS5NMyt1R134rT6fuFIiwO
X-Gm-Gg: ASbGncsm1ZwLqD1iuNkdqCfkmbESkw+ofwC/zCKjq02wcLTuvYV642cViHLJpgB6upO
	rKDCvTXI//biUkljiPEHZaE6NhpuMcY4DuFReCSKmJbwmd/5cLGwGW/xdbReBeQ6x5daHO0pzYB
	0oPFAT1UONcdHwbnkqaQZHGLs1VPgItdeJA+D25s4veViRMUdlTh3sfxB9/oY/51Cf/+93h/4W9
	sAku/AUslM/ZN42OLMviyRBS4BCkWeb2i9goueHWvwGCQC+6V6kCO1T5tF1k3aRLmmdttfecxa5
	/PcaIM/gqVCoEVdZPuxaABjFC/aibPu8OB3e3tkfT5x2MINAh1/v4yuIze5yqPpMtwx0DYcygLp
	hXgKrPsg96V4oW6xNgZB5WuThLZerj/Q+4N0mBMStNlJxEAyte5iw8+XM/IOfyFeMQ5fAu/waw3
	u/Wm3tXPUgN+w=
X-Google-Smtp-Source: AGHT+IFZTfSSmOqsnzyenxwbnVCwSP1cwq60iDyw7m55VKi4EtHZ+78miYEWY5PRHYIS5Aaap/hNxQ==
X-Received: by 2002:a05:6a00:230b:b0:7a2:81fe:b742 with SMTP id d2e1a72fcca58-7ae1d63f297mr9571953b3a.12.1762430179016;
        Thu, 06 Nov 2025 03:56:19 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7c4115a9sm2648580b3a.0.2025.11.06.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:56:18 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Thu, 06 Nov 2025 17:25:48 +0530
Subject: [PATCH v3] net: ethernet: fix uninitialized pointers with free
 attribute
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMOMDGkC/52NsQ6CMBRFf4V09pkWaCFO/odxaOkDXgLFlNqoh
 H+3MLHqds8dzlnYjJ5wZpdsYR4jzTS5BMUpY02vXYdANjHLeS6F4BJ0jxjh6chRID3QBy20HhF
 0CB4cBsDQo99GZQVXWGpTtBVLwofHll577HZP3NMcJv/e21Fs71+ZKEBAq1DXpTG2kvzajZqGc
 zONbMvE/KhWP6nzpOZlbTVvpFVGHdXrun4B25jupz8BAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=F5ah8MsnK3Z9znouBMKy+zHLSoJBwjNa27W+pmH6JFY=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ5ei7Ny4nVWfJeUGdH1rezCw5x/ljgOH9Tku3f6Bfbb
 3n5zI/b0lHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBErjxk+Gdsc+VJcu2UZ76Z
 Mq++hx007zi/87TXp1fBFSw28svXBskzMuz7vfxP6VEnIc2bpmJMT+PsuSRftbJyfHZ00HG+I+d
 Szg8A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

It is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v3:
- fixed style issues
- Link to v2: https://lore.kernel.org/r/20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com

Changes in v2:
- fixed non-pointer initialization to NULL
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


