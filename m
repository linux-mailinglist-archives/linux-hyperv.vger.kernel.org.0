Return-Path: <linux-hyperv+bounces-11973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LUQCRQnVmq+0AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11973-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 14:09:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EE875450A
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 14:09:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DFvR9HIH;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11973-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11973-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC82C334ABAA
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1B39C017;
	Tue, 14 Jul 2026 11:47:06 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323839183B;
	Tue, 14 Jul 2026 11:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029626; cv=none; b=HJ81hhDD2RXcF4WlqsdczeTYj2ljPTR5sBZg9MKmJ+GEZRt7s0rtcyhKc/A3dMQVcTnKBSt8ooiRhXoe01wkwSMGKYonVHyqJA9lCQ/Z7tdytDvbHZdXzvTFt5ettagURDjpqoPtdsf2kqvNNpCqczqfEgZEgYCEXvU0/B09lsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029626; c=relaxed/simple;
	bh=1dTa0XFIwErMClVks+b1+dKviz4MPuVNcPk/8vKU4eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ujed6M8X6xroxLyb6hy1s6wG5eQwnBY+BxeTxwBQG+RnHtu4/vOoO7i0ucG39tUvGNrJqegjkZLnympqF4pXNXjy9pdTtc+rYUsuMA1gWNI/kmqZkrNfFK77abrKHVe8jMO8rVFlz0yuxQSaIETzFBts0T+Joe9U+NU+nrVUvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFvR9HIH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC92C1F00ACF;
	Tue, 14 Jul 2026 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029624;
	bh=ejJXmN+NxYJQWTWGFPBXvRVoH1woJz/emA0CZD5PWyQ=;
	h=From:To:Cc:Subject:Date;
	b=DFvR9HIH7g0adyo6JcvLuosHcUnedfPNsf0WhHmPzwSGRG7fsHQscpZoEBwulSEGb
	 OG5IdiTPt78bHHf2Tdrg3u778aWOv3sJNmBY8eeW7w1S/mwzNfEj4eivKWeMNcVln3
	 iXaR5NBZLLAgjoLePV3+e9Btb5GUzoZXKlRAfsJIzovu1s9PW1718SGnA6zU4OMsRq
	 AYoVzg7QKcqKlfZV1vjg50ApHmKnq3nm9bfCuEW0b4gQTMVClGffp575zvBlj4fP57
	 soQ+TZNs3JL0OqaqA0TZYNnyTOH4jpH16xrAndbhDIXjTefNj2ik7Mn7y2MXMsE/yh
	 1yzk5Uu0LqdXw==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bernard.metzler@linux.dev>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next] RDMA: Use ib_no_udata_io() in query_device callbacks
Date: Tue, 14 Jul 2026 14:46:58 +0300
Message-ID: <20260714-convert-to-noio-udata-v1-1-f1f6b6c7c988@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260714-convert-to-noio-udata-28749ec5a250
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:jgg@ziepe.ca,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:selvin.xavier@broadcom.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:dennis.dalessandro@cornelisnetworks.com,m:zyjzyj2000@gmail.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[chelsio.com,ziepe.ca,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,broadcom.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,linux.dev];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11973-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70EE875450A

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
The query_device callbacks that neither accept driver-specific input nor=0D
return a driver-specific response open-code the empty udata handling as=0D
ib_is_udata_in_empty() on entry and ib_respond_empty_udata() on exit.=0D
=0D
ib_no_udata_io() already combines both steps, so replace the entry check=0D
with it and simply return 0 on success.=0D
=0D
Unlike the create and destroy flows, query_device owns no uobject or HW=0D
resource - the extended path fills a stack ib_device_attr that the core=0D
discards on error - so clearing the empty response buffer on entry rather=0D
than on exit is a mechanical change with no functional difference.=0D
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/hw/cxgb4/provider.c          | 4 ++--=0D
 drivers/infiniband/hw/erdma/erdma_verbs.c       | 4 ++--=0D
 drivers/infiniband/hw/hns/hns_roce_main.c       | 4 ++--=0D
 drivers/infiniband/hw/ionic/ionic_ibdev.c       | 4 ++--=0D
 drivers/infiniband/hw/irdma/verbs.c             | 4 ++--=0D
 drivers/infiniband/hw/mana/main.c               | 4 ++--=0D
 drivers/infiniband/hw/mthca/mthca_provider.c    | 3 +--=0D
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     | 4 ++--=0D
 drivers/infiniband/hw/qedr/verbs.c              | 4 ++--=0D
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    | 4 ++--=0D
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 4 ++--=0D
 drivers/infiniband/sw/rdmavt/vt.c               | 4 ++--=0D
 drivers/infiniband/sw/rxe/rxe_verbs.c           | 4 ++--=0D
 drivers/infiniband/sw/siw/siw_verbs.c           | 4 ++--=0D
 14 files changed, 27 insertions(+), 28 deletions(-)=0D
=0D
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw=
/cxgb4/provider.c=0D
index e1eec37ee822..ebe3170a641c 100644=0D
--- a/drivers/infiniband/hw/cxgb4/provider.c=0D
+++ b/drivers/infiniband/hw/cxgb4/provider.c=0D
@@ -263,7 +263,7 @@ static int c4iw_query_device(struct ib_device *ibdev, s=
truct ib_device_attr *pro=0D
 =0D
 	pr_debug("ibdev %p\n", ibdev);=0D
 =0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -300,7 +300,7 @@ static int c4iw_query_device(struct ib_device *ibdev, s=
truct ib_device_attr *pro=0D
 	props->max_fast_reg_page_list_len =3D=0D
 		t4_max_fr_depth(dev->rdev.lldi.ulptx_memwrite_dsgl && use_dsgl);=0D
 =0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 static int c4iw_query_port(struct ib_device *ibdev, u32 port,=0D
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband=
/hw/erdma/erdma_verbs.c=0D
index 9491cbab69b3..71e3e8618a61 100644=0D
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c=0D
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c=0D
@@ -320,7 +320,7 @@ int erdma_query_device(struct ib_device *ibdev, struct =
ib_device_attr *attr,=0D
 	struct erdma_dev *dev =3D to_edev(ibdev);=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(udata);=0D
+	err =3D ib_no_udata_io(udata);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -361,7 +361,7 @@ int erdma_query_device(struct ib_device *ibdev, struct =
ib_device_attr *attr,=0D
 		addrconf_addr_eui48((u8 *)&attr->sys_image_guid,=0D
 				    dev->netdev->dev_addr);=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 int erdma_query_gid(struct ib_device *ibdev, u32 port, int idx,=0D
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband=
/hw/hns/hns_roce_main.c=0D
index 09c07de5f022..662959efcf31 100644=0D
--- a/drivers/infiniband/hw/hns/hns_roce_main.c=0D
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c=0D
@@ -223,7 +223,7 @@ static int hns_roce_query_device(struct ib_device *ib_d=
ev,=0D
 	struct hns_roce_dev *hr_dev =3D to_hr_dev(ib_dev);=0D
 	int ret;=0D
 =0D
-	ret =3D ib_is_udata_in_empty(uhw);=0D
+	ret =3D ib_no_udata_io(uhw);=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
@@ -277,7 +277,7 @@ static int hns_roce_query_device(struct ib_device *ib_d=
ev,=0D
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)=0D
 		props->device_cap_flags |=3D IB_DEVICE_XRC;=0D
 =0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,=0D
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband=
/hw/ionic/ionic_ibdev.c=0D
index b0449c75f893..2b91bd03c73e 100644=0D
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c=0D
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c=0D
@@ -27,7 +27,7 @@ static int ionic_query_device(struct ib_device *ibdev,=0D
 	struct net_device *ndev;=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(udata);=0D
+	err =3D ib_no_udata_io(udata);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -74,7 +74,7 @@ static int ionic_query_device(struct ib_device *ibdev,=0D
 	attr->max_fast_reg_page_list_len =3D dev->lif_cfg.npts_per_lif / 2;=0D
 	attr->max_pkeys =3D IONIC_PKEY_TBL_LEN;=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 static int ionic_query_port(struct ib_device *ibdev, u32 port,=0D
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/ir=
dma/verbs.c=0D
index c9b606cc67d4..f48cc8b5299b 100644=0D
--- a/drivers/infiniband/hw/irdma/verbs.c=0D
+++ b/drivers/infiniband/hw/irdma/verbs.c=0D
@@ -18,7 +18,7 @@ static int irdma_query_device(struct ib_device *ibdev,=0D
 	struct irdma_hw_attrs *hw_attrs =3D &rf->sc_dev.hw_attrs;=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(udata);=0D
+	err =3D ib_no_udata_io(udata);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -75,7 +75,7 @@ static int irdma_query_device(struct ib_device *ibdev,=0D
 	if (hw_attrs->uk_attrs.hw_rev >=3D IRDMA_GEN_3)=0D
 		props->device_cap_flags |=3D IB_DEVICE_MEM_WINDOW_TYPE_2B;=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 /**=0D
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana=
/main.c=0D
index a5b3606a1dd5..73f4bfb22b5e 100644=0D
--- a/drivers/infiniband/hw/mana/main.c=0D
+++ b/drivers/infiniband/hw/mana/main.c=0D
@@ -575,7 +575,7 @@ int mana_ib_query_device(struct ib_device *ibdev, struc=
t ib_device_attr *props,=0D
 	struct pci_dev *pdev =3D to_pci_dev(mdev_to_gc(dev)->dev);=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -604,7 +604,7 @@ int mana_ib_query_device(struct ib_device *ibdev, struc=
t ib_device_attr *props,=0D
 	if (!mana_ib_is_rnic(dev))=0D
 		props->raw_packet_caps =3D IB_RAW_PACKET_CAP_IP_CSUM;=0D
 =0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 int mana_ib_query_port(struct ib_device *ibdev, u32 port,=0D
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c=0D
index e933a53779a4..6575493f4eab 100644=0D
--- a/drivers/infiniband/hw/mthca/mthca_provider.c=0D
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c=0D
@@ -58,7 +58,7 @@ static int mthca_query_device(struct ib_device *ibdev, st=
ruct ib_device_attr *pr=0D
 	int err;=0D
 	struct mthca_dev *mdev =3D to_mdev(ibdev);=0D
 =0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -112,7 +112,6 @@ static int mthca_query_device(struct ib_device *ibdev, =
struct ib_device_attr *pr=0D
 	props->max_total_mcast_qp_attach =3D props->max_mcast_qp_attach *=0D
 					   props->max_mcast_grp;=0D
 =0D
-	err =3D ib_respond_empty_udata(uhw);=0D
  out:=0D
 	kfree(in_mad);=0D
 	kfree(out_mad);=0D
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c=0D
index de83dc0ea79c..cfe3d19b73b3 100644=0D
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c=0D
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c=0D
@@ -70,7 +70,7 @@ int ocrdma_query_device(struct ib_device *ibdev, struct i=
b_device_attr *attr,=0D
 	struct ocrdma_dev *dev =3D get_ocrdma_dev(ibdev);=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -111,7 +111,7 @@ int ocrdma_query_device(struct ib_device *ibdev, struct=
 ib_device_attr *attr,=0D
 	attr->local_ca_ack_delay =3D dev->attr.local_ca_ack_delay;=0D
 	attr->max_fast_reg_page_list_len =3D dev->attr.max_pages_per_frmr;=0D
 	attr->max_pkeys =3D 1;=0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 static inline void get_link_speed_and_width(struct ocrdma_dev *dev,=0D
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c=0D
index 1cf502579ad1..012a0ab98d6b 100644=0D
--- a/drivers/infiniband/hw/qedr/verbs.c=0D
+++ b/drivers/infiniband/hw/qedr/verbs.c=0D
@@ -114,7 +114,7 @@ int qedr_query_device(struct ib_device *ibdev,=0D
 		return -EINVAL;=0D
 	}=0D
 =0D
-	rc =3D ib_is_udata_in_empty(udata);=0D
+	rc =3D ib_no_udata_io(udata);=0D
 	if (rc)=0D
 		return rc;=0D
 =0D
@@ -158,7 +158,7 @@ int qedr_query_device(struct ib_device *ibdev,=0D
 	attr->max_pkeys =3D qattr->max_pkey;=0D
 	attr->max_ah =3D qattr->max_ah;=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 static inline void get_link_speed_and_width(int speed, u16 *ib_speed,=0D
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infinib=
and/hw/usnic/usnic_ib_verbs.c=0D
index 3402c84eb904..1a1647d0e345 100644=0D
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c=0D
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c=0D
@@ -278,7 +278,7 @@ int usnic_ib_query_device(struct ib_device *ibdev,=0D
 	int err;=0D
 =0D
 	usnic_dbg("\n");=0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -323,7 +323,7 @@ int usnic_ib_query_device(struct ib_device *ibdev,=0D
 	 * max_qp_wr, max_sge, max_sge_rd, max_cqe */=0D
 	mutex_unlock(&us_ibdev->usdev_lock);=0D
 =0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 int usnic_ib_query_port(struct ib_device *ibdev, u32 port,=0D
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infi=
niband/hw/vmw_pvrdma/pvrdma_verbs.c=0D
index 1d29a535f76a..59c2a88c158a 100644=0D
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c=0D
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c=0D
@@ -69,7 +69,7 @@ int pvrdma_query_device(struct ib_device *ibdev,=0D
 	struct pvrdma_dev *dev =3D to_vdev(ibdev);=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -116,7 +116,7 @@ int pvrdma_query_device(struct ib_device *ibdev,=0D
 	props->device_cap_flags |=3D IB_DEVICE_PORT_ACTIVE_EVENT |=0D
 				   IB_DEVICE_RC_RNR_NAK_GEN;=0D
 =0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 /**=0D
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdma=
vt/vt.c=0D
index f37d6d64adb9..1c112f4dc994 100644=0D
--- a/drivers/infiniband/sw/rdmavt/vt.c=0D
+++ b/drivers/infiniband/sw/rdmavt/vt.c=0D
@@ -84,14 +84,14 @@ static int rvt_query_device(struct ib_device *ibdev,=0D
 	struct rvt_dev_info *rdi =3D ib_to_rvt(ibdev);=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(uhw);=0D
+	err =3D ib_no_udata_io(uhw);=0D
 	if (err)=0D
 		return err;=0D
 	/*=0D
 	 * Return rvt_dev_info.dparms.props contents=0D
 	 */=0D
 	*props =3D rdi->dparms.props;=0D
-	return ib_respond_empty_udata(uhw);=0D
+	return 0;=0D
 }=0D
 =0D
 static int rvt_get_numa_node(struct ib_device *ibdev)=0D
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c=0D
index 1ec130fee8ea..c8562866e21f 100644=0D
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c=0D
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c=0D
@@ -22,13 +22,13 @@ static int rxe_query_device(struct ib_device *ibdev,=0D
 	struct rxe_dev *rxe =3D to_rdev(ibdev);=0D
 	int err;=0D
 =0D
-	err =3D ib_is_udata_in_empty(udata);=0D
+	err =3D ib_no_udata_io(udata);=0D
 	if (err)=0D
 		return err;=0D
 =0D
 	memcpy(attr, &rxe->attr, sizeof(*attr));=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 static int rxe_query_port(struct ib_device *ibdev,=0D
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/=
siw/siw_verbs.c=0D
index e281517fc6f9..4ba6d6d5afe9 100644=0D
--- a/drivers/infiniband/sw/siw/siw_verbs.c=0D
+++ b/drivers/infiniband/sw/siw/siw_verbs.c=0D
@@ -132,7 +132,7 @@ int siw_query_device(struct ib_device *base_dev, struct=
 ib_device_attr *attr,=0D
 	struct siw_device *sdev =3D to_siw_dev(base_dev);=0D
 	int rv;=0D
 =0D
-	rv =3D ib_is_udata_in_empty(udata);=0D
+	rv =3D ib_no_udata_io(udata);=0D
 	if (rv)=0D
 		return rv;=0D
 =0D
@@ -165,7 +165,7 @@ int siw_query_device(struct ib_device *base_dev, struct=
 ib_device_attr *attr,=0D
 	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,=0D
 			    sdev->raw_gid);=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 int siw_query_port(struct ib_device *base_dev, u32 port,=0D
=0D
---=0D
base-commit: eeb9697db6c16d9bb2ce7b7ddf95aa20305aa9f2=0D
change-id: 20260714-convert-to-noio-udata-28749ec5a250=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

