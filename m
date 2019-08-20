Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD48954BB
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 05:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfHTDB0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 23:01:26 -0400
Received: from mail-eopbgr820132.outbound.protection.outlook.com ([40.107.82.132]:10944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbfHTDB0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 23:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBPgzSExguzpf/FibGREr8xL7D9p4ezndauktctv88tuf2jN+K4xdovoyt3fbOlaXL2cR+3JNvRjPu7L5EpAQQ23MRQs8LSRTKk1+v6i5+u9bUizhSBJRbTwq5WpLvY/0gpIsYrxqOSLEaKp3PcJ5DX2Ee/sJ03o1Nxzcr6p26j6p7R2ue8QpPXKArzA2Q+pJ+BRyGTcu5PKxGKx8sDSeuHLIH3MxFlzToZZYLT0y15VLSscOdM6yVRrlKEDTUgMfoFKH88U4mu/X2O+SnY+VuUILNH78k7a6MiP6fAJ/lhFkab0nB5Eu0zVFP7u6V3ThdEUSkhMWC9qIAXzHEbYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF3xFDABSJTdHjbvOR7kZOhMLzhL92a6uUmYOmxKPl8=;
 b=GK3xhlJwzf7dMfXKqFrRKGKkZF+JhzMvjbPjxe289wtKBIMRdCx84Qtm/fmrJgaZuvL7VkGwBbpRtIF1dPg+2BRUsPTPsRT0j7OwvYBviAusCzszMrrWBs6TjBpRpop7RBbGbxDtO4BNwb0SrBLekZyD8+qw9/57YYhGp6sq5rzGJT/bMnIgOT8S2W5VE+EC08D970uCMCVNpZ6tLNAUQ1kCuqD+aCOtNytPcFEEgwunJG1bGOM8AeZwIEBkcDSiI/pwq8QJzLFK1Wm6RyK5O6i/PUn617w27qmPraZMBX7w1wLISk/vi2qrT1qpPJuno/edfPKLTCIoD8jrStKzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF3xFDABSJTdHjbvOR7kZOhMLzhL92a6uUmYOmxKPl8=;
 b=d7r198O6QZTgSt2hK2BOrEz2nGxorGZUaWRHTLGlPa0scNpaoaOn9TuRRCQsrPsGaGJRcgfzw0BjmZxg2uXITsO/PNsUY+N9DbEABaqBs6NooipolNj9vABAfkHaHa72BeUeU+rt8kgdQdoByH0z4qtEKMFfnKw4h6HQtttupMg=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1134.namprd21.prod.outlook.com (52.132.114.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 03:01:24 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 03:01:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
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
Subject: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Thread-Topic: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Thread-Index: AQHVVwONu41b0wbEXE+C24LSIGy5og==
Date:   Tue, 20 Aug 2019 03:01:23 +0000
Message-ID: <1566270066-27546-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:102:2::43) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d08d9e97-0d36-40b3-44c0-08d7251aaf5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1134;
x-ms-traffictypediagnostic: SN6PR2101MB1134:|SN6PR2101MB1134:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB1134F18824704D19B61EE97FBFAB0@SN6PR2101MB1134.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(102836004)(2616005)(26005)(99286004)(3450700001)(22452003)(6486002)(966005)(14454004)(10290500003)(6116002)(7736002)(53936002)(6436002)(186003)(305945005)(86362001)(2201001)(476003)(6636002)(66066001)(6512007)(5660300002)(4720700003)(486006)(36756003)(1511001)(81156014)(25786009)(71190400001)(52116002)(66946007)(110136005)(6306002)(50226002)(256004)(6506007)(66556008)(2906002)(10090500001)(81166006)(54906003)(478600001)(386003)(43066004)(107886003)(316002)(8676002)(8936002)(66446008)(66476007)(4326008)(64756008)(3846002)(2501003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1134;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jilrmldxadst5QXklen359MM0GWsfkiJozreo7YAfe+aELhQeF+iTaSAvAbDJqbBgh7xWWgn65HXi4Zbc3XFimLsok3aaUDNonvA/3qETVzceBcBDMhsMMfEDh4JTyAkR3HgoQd/ukmvLL7vCBW2hw4kweCfXyhlIJ2kqsMCDWOcY9L4CtJ7iuv6wmUZVL/WXTIoZbFDg2dXfJ4xbnMcWoV3LnojXtRKhfj70RrpW+b7+8XhxL/NvCMW3CK+dHqLVzLiCkR2fvuitSt9GlPxHekSyth4t/CXUgjZbFJqk2Bc0pyB/GdZWOQIERvXBghuPoXDOeA7CprTcIBmBAYGE778CFARWWI61FKQyWqk14A19SlAoeUjnNUoJN5NfCNEYqvP77G1XAxxj8EdAn1gUTae7VS4RdNO1l97MMI/1yI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08d9e97-0d36-40b3-44c0-08d7251aaf5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 03:01:23.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os5vjjHTNA7rT0K5jZ/2nPE6tV/gfoEI9fYIAbs3PasAARdsPIrh9qLe+U0e0tb2UmFUhvXMDerIS3UqlBq4Ig==
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

Hi Dmitry, can this patch go through Sasha's hyperv tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git

This is a purely Hyper-V specific change.

 drivers/input/serio/hyperv-keyboard.c | 35 ++++++-------------------------=
----
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hy=
perv-keyboard.c
index 88ae7c2..e486a8a 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -237,40 +237,17 @@ static void hv_kbd_handle_received_packet(struct hv_d=
evice *hv_dev,
=20
 static void hv_kbd_on_channel_callback(void *context)
 {
+	struct vmpacket_descriptor *desc;
 	struct hv_device *hv_dev =3D context;
-	void *buffer;
-	int bufferlen =3D 0x100; /* Start with sensible size */
 	u32 bytes_recvd;
 	u64 req_id;
-	int error;
=20
-	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
-	if (!buffer)
-		return;
-
-	while (1) {
-		error =3D vmbus_recvpacket_raw(hv_dev->channel, buffer, bufferlen,
-					     &bytes_recvd, &req_id);
-		switch (error) {
-		case 0:
-			if (bytes_recvd =3D=3D 0) {
-				kfree(buffer);
-				return;
-			}
-
-			hv_kbd_handle_received_packet(hv_dev, buffer,
-						      bytes_recvd, req_id);
-			break;
+	foreach_vmbus_pkt(desc, hv_dev->channel) {
+		bytes_recvd =3D desc->len8 * 8;
+		req_id =3D desc->trans_id;
=20
-		case -ENOBUFS:
-			kfree(buffer);
-			/* Handle large packet */
-			bufferlen =3D bytes_recvd;
-			buffer =3D kmalloc(bytes_recvd, GFP_ATOMIC);
-			if (!buffer)
-				return;
-			break;
-		}
+		hv_kbd_handle_received_packet(hv_dev, desc, bytes_recvd,
+					      req_id);
 	}
 }
=20
--=20
1.8.3.1

