Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5286B954AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 04:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHTC5S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 22:57:18 -0400
Received: from mail-eopbgr820103.outbound.protection.outlook.com ([40.107.82.103]:7241
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTC5S (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 22:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf7Cqr9BWFML/HneJ3dKhQ1xdlCoEZVG+T/mLxtkYPqn9qfSUgwCzqR689PeyTMyEBgWGNJttf8UPzdly4tOwGKrYjaNN7zkZc10oQ1hkbp6BAoK8BZTF+HAw2nf9X9f0AdIltTX6+PxGo7e4lEqXO1PpM3CAgENBvATdLSio3tHl7/+sXFDAcaVqgqEfHj3A5r6Z4QimMje9hGfvImp8K1Q3kF3VDlmNmocOXgzYy3vV+DfKYKWBmzc+0uyOQ5h0HpvGLiB/LkAASq4AI3Y76fnW5EY/+pC5GLUCqBV1PscQnIY49Z77uHn6AhjQ2BcVkII3+ad/lLq83Gb01kMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLt5DwsVigiQYnNmQqiUv1i+BQ5dIq+SPsTH0QLPkks=;
 b=iGyz5S0GSO6AxhhQPDsOZhkMdMaSb3pI/FAR7vYcq0jjomaYk50hTjjDWw0ap4/MQtleCku3zmB67Seqw+ik6vqyCNXc8vd1RnqJ8/GIGGCJM1nmep+x0/fos6VF+aLmOtB0QjSfY0QypQVmHsYxc0Uo3s+vpIlszLrtuY0ZKCpWFzTND0/knpGZyNmtCK5fiUDMSF1cdUwg4PoPxm6H2hlmpTpZhMg1hw+PRqiwlBCPHBayFWpxCwYDmRNV+QWpaCz0l5uQo3EV6FENvTWt3cO6DQ4113mJ7F7bP4CnUB49hIZLg4q4MF5jeppTHOifATroveBrLC24+TcRJZgEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLt5DwsVigiQYnNmQqiUv1i+BQ5dIq+SPsTH0QLPkks=;
 b=Kyl1K68YPXIzRyjGrPFSZeODzWGvVfknuCbVAo5dNpkChwIBFspx9sapba1De4zYKFtH12sXc/PLjpJrPpUalaoA8vc5yLgJiCiI6G3SZQcRIgYeRc+IZPdRj8d+2vnQSJFLoA3O7K73z1iJUEsdbJTWEtj3w/KkSK1Q0EJSAXk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1134.namprd21.prod.outlook.com (52.132.114.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 02:56:34 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 02:56:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Thread-Topic: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Thread-Index: AQHVVwLgob1PhqdeUUavARficZPulA==
Date:   Tue, 20 Aug 2019 02:56:34 +0000
Message-ID: <1566269763-26817-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:300:d4::11) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4e3156d-a898-4511-94c5-08d7251a02cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1134;
x-ms-traffictypediagnostic: SN6PR2101MB1134:|SN6PR2101MB1134:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB1134C0AF1B15D0F7B077C9ACBFAB0@SN6PR2101MB1134.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(102836004)(2616005)(26005)(99286004)(3450700001)(22452003)(6486002)(966005)(14454004)(10290500003)(6116002)(7736002)(53936002)(6436002)(186003)(305945005)(86362001)(2201001)(476003)(6636002)(66066001)(6512007)(5660300002)(4720700003)(486006)(36756003)(1511001)(81156014)(25786009)(71190400001)(52116002)(66946007)(110136005)(6306002)(50226002)(256004)(6506007)(66556008)(2906002)(10090500001)(81166006)(54906003)(478600001)(386003)(43066004)(107886003)(316002)(8676002)(8936002)(66446008)(66476007)(4326008)(64756008)(3846002)(2501003)(71200400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1134;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5M7Fv80H0zyVDZX6GIsGAI2veuK1DQn51gl7AJNItlaYl4HWmZ/k9afBTS38XaGv0M1baT+H/ZShuxqWopvNqJy2+2Bg3TT43pigBT/2ENvxfU/PIsOegZz42XLcQ0vAoVvOu3FpGGNhnfGd+EyYbKhYwJmZ25Tun5blu2hGQTjbi5iYC8RVmayD6Eg2EjgQir4+ZfyMyBeg/DIcxCc9wHTGp9MGL984MCwl0Zw+ew5CHFLhe0fJ4YpULdYrOZ4KZELYC3/C5F28tfVnKaD+lQoVuLsazjHIli2Q6IOh+JYxj4VNtXJqIhnCYuvNPQoRa7fbuHsmeLpDT1Kh2qOU7UEKm8XHWeXKAPz1h/iVKaJiN48JOQ1RpHFKtUBzdZ9e0U2fT7oxfdmDp95OGybH0BGS08l2xJrZGheB8iPT8KE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e3156d-a898-4511-94c5-08d7251a02cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 02:56:34.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGqEzFhUXtCrtkjx9wOAiNAdyOOxnnh6REx3FbT7n06Ctmm//lqv3Qd43qKh6aLh3//uaFeCSHWCvx1jGTg+eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1134
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Simplify the ring buffer handling with the in-place API.

Also avoid the dynamic allocation and the memory leak in the channel
callback function.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git

This is a purely Hyper-V specific change.

 drivers/hid/hid-hyperv.c | 56 +++++++++-----------------------------------=
----
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 7795831..f363163 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -314,60 +314,24 @@ static void mousevsc_on_receive(struct hv_device *dev=
ice,
=20
 static void mousevsc_on_channel_callback(void *context)
 {
-	const int packet_size =3D 0x100;
-	int ret;
 	struct hv_device *device =3D context;
-	u32 bytes_recvd;
-	u64 req_id;
 	struct vmpacket_descriptor *desc;
-	unsigned char	*buffer;
-	int	bufferlen =3D packet_size;
-
-	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
-	if (!buffer)
-		return;
-
-	do {
-		ret =3D vmbus_recvpacket_raw(device->channel, buffer,
-					bufferlen, &bytes_recvd, &req_id);
-
-		switch (ret) {
-		case 0:
-			if (bytes_recvd <=3D 0) {
-				kfree(buffer);
-				return;
-			}
-			desc =3D (struct vmpacket_descriptor *)buffer;
-
-			switch (desc->type) {
-			case VM_PKT_COMP:
-				break;
-
-			case VM_PKT_DATA_INBAND:
-				mousevsc_on_receive(device, desc);
-				break;
-
-			default:
-				pr_err("unhandled packet type %d, tid %llx len %d\n",
-					desc->type, req_id, bytes_recvd);
-				break;
-			}
=20
+	foreach_vmbus_pkt(desc, device->channel) {
+		switch (desc->type) {
+		case VM_PKT_COMP:
 			break;
=20
-		case -ENOBUFS:
-			kfree(buffer);
-			/* Handle large packet */
-			bufferlen =3D bytes_recvd;
-			buffer =3D kmalloc(bytes_recvd, GFP_ATOMIC);
-
-			if (!buffer)
-				return;
+		case VM_PKT_DATA_INBAND:
+			mousevsc_on_receive(device, desc);
+			break;
=20
+		default:
+			pr_err("Unhandled packet type %d, tid %llx len %d\n",
+			       desc->type, desc->trans_id, desc->len8 * 8);
 			break;
 		}
-	} while (1);
-
+	}
 }
=20
 static int mousevsc_connect_to_vsp(struct hv_device *device)
--=20
1.8.3.1

