Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A98BB05EE
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfIKXfT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:35:19 -0400
Received: from mail-eopbgr770124.outbound.protection.outlook.com ([40.107.77.124]:55939
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXfT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9I2tB8TkewRvrxLzeY0MXyU9/wiJnG7CL0f1hH5/M4Yrumq+LBY8sYmy0IcRUauNmrbM2F2V8QQ6rkCt30K7UMgI+/bBHIHu7bOwy/FBW1v9Q2VnR70jfHc0VzoC1r1fi/xYMmmv53aC+CF0Cp1HMjrvAuLPJshUAXLy56qfXM3VyxTdaPjrxM+9SkqHV/7bon9dRdmFRIfKSqsSFDjULBHnabRIV7zJWhjiKONRMPy4z7wOMN0ZloovA+Pbff19mjIJapvZdABNKF2KAEJ4PyfRDg0IoUKn9QX2ckYQ3lRR1xWukpctgKa4EFN7KTo9r/OuP1m7yUm90BY7UGZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUdyIerOvZn8WQEiEu5WWdzAT1S478LEaLVDQrossB0=;
 b=DXBKlKCdp/tyQWlYrUaak7Pk1llKcsyV2GxYf6m1j9zL5yetJMYMGqaH/9c2O8/tylZLF1898zo+WP7cScEHqBMDuKJ09D7oyAaMnnqzDRlWPbYLW2S7g7FTeVZN4CZTrV0DCmt63z9THR2IDjVh8jjj6PMp+zZUSnYKzPpSGfVWfUoEIwm0zJ+yq4K0HsAXubwvZb2Ukh3DY8LztdGlYiEGdS9TwNCnTnsKzKd89/tXYHTlsSl45Zrbzlx/cVuVmSttIDwyH/v2q/i+n6epofg/X8WKeQ61uuRUcUTH8gcFJ4W2J2+Q34DzSy8UcLip1vFGmcM2Cgua/VO1SgbNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUdyIerOvZn8WQEiEu5WWdzAT1S478LEaLVDQrossB0=;
 b=h06eJY3aUUGoYwIJ6l58fHS2Z85q3DIqwLzmCIWkw7DNiCK0DfXd1cKC4tVWxk9qhmnZtPV8nSh2+Zl8T/VOau3oumH8QRV5YW2FO80mG178EQE2cnF/YYKC7Q6dUUHpyEXL9gKuFylKFgswFU1g3E5TGPQ/Zpou47ev6DKLYcY=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:35:16 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:35:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] scsi: storvsc: Add the support of hibernation
Thread-Topic: [PATCH] scsi: storvsc: Add the support of hibernation
Thread-Index: AQHVaPmQQ30E4hrjgUuSDngi9Du3cA==
Date:   Wed, 11 Sep 2019 23:35:16 +0000
Message-ID: <1568244905-66625-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59cbefb5-c9dd-4a4b-91d4-08d73710b31c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB09096FC2612C8E959D95AAEEBFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(3450700001)(6512007)(6306002)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(966005)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s9rujWZM/0rorl9a2CyfBGdzOF+58q0urFMvYQp5Ruf9pA1vY2+KmFgmwx0n230OvF8SJyyfigeZK5PK+BvqR7dPZ6kYjWZLbj8Fq8+7Hezb509N0KAgFFGcXKNq1yCCX4K8E22cP1ghAPDrg4IdsCp9fZJdTcDxNIPEsWu9gTMbHa6A9XTXc59SKdTBP96EpMkJ/JwYjvrqgZ82TWRFO4DRbdUP+b+04pR5f2DQ33xeG5zNGad/lGNfAiaTqyc7swFGa6WdkgGp1EOBKEHGpu0uxvYoLXXK/jvoddUjEBmyalP5nxQoekWzTJ0miaqgKb3Iz21WKwGNP1zlR6VjT/O3XUdD9eraE1jpJ7mGRyW6s5bCcLannS2nbFiWrucWdpMyMfv9fUImDzpMetFLb2lraclLWSZzNi6TKfDc0DA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cbefb5-c9dd-4a4b-91d4-08d73710b31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:35:16.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64LNPdQUhPL7oR6hbsEs/pI8cH/+CiI9sycVPdtUDTFBC400RvYvy9PHUHDWU0U25kN1zOiPQL3H/kbIpSV5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When we're in storvsc_suspend(), we're sure the SCSI layer has quiesced the
scsi device by scsi_bus_suspend() -> ... -> scsi_device_quiesce(), so the
low level SCSI adapter driver only needs to suspend/resume its own state.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
SCSI tree.

 drivers/scsi/storvsc_drv.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ed8b9ac..9fbf604 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1727,6 +1727,13 @@ enum {
=20
 MODULE_DEVICE_TABLE(vmbus, id_table);
=20
+static const struct { guid_t guid; } fc_guid =3D { HV_SYNTHFC_GUID };
+
+static bool hv_dev_is_fc(struct hv_device *hv_dev)
+{
+	return guid_equal(&fc_guid.guid, &hv_dev->dev_type);
+}
+
 static int storvsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -1935,11 +1942,45 @@ static int storvsc_remove(struct hv_device *dev)
 	return 0;
 }
=20
+static int storvsc_suspend(struct hv_device *hv_dev)
+{
+	struct storvsc_device *stor_device =3D hv_get_drvdata(hv_dev);
+	struct Scsi_Host *host =3D stor_device->host;
+	struct hv_host_device *host_dev =3D shost_priv(host);
+
+	storvsc_wait_to_drain(stor_device);
+
+	drain_workqueue(host_dev->handle_error_wq);
+
+	vmbus_close(hv_dev->channel);
+
+	memset(stor_device->stor_chns, 0,
+	       num_possible_cpus() * sizeof(void *));
+
+	kfree(stor_device->stor_chns);
+	stor_device->stor_chns =3D NULL;
+
+	cpumask_clear(&stor_device->alloced_cpus);
+
+	return 0;
+}
+
+static int storvsc_resume(struct hv_device *hv_dev)
+{
+	int ret;
+
+	ret =3D storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
+				     hv_dev_is_fc(hv_dev));
+	return ret;
+}
+
 static struct hv_driver storvsc_drv =3D {
 	.name =3D KBUILD_MODNAME,
 	.id_table =3D id_table,
 	.probe =3D storvsc_probe,
 	.remove =3D storvsc_remove,
+	.suspend =3D storvsc_suspend,
+	.resume =3D storvsc_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1

