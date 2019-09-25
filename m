Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC0BE62C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2019 22:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbfIYULM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 16:11:12 -0400
Received: from mail-eopbgr800097.outbound.protection.outlook.com ([40.107.80.97]:12768
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731229AbfIYULM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 16:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNeKu2ctkqmAVAubEJ2G+JNH+o3mnF9fRiy/exkKXLjoBd6FCAMaVfr/KBOBHWUItbbKcwxGXYxBsGy58NZyhPxDrpzRZmHjbludIenjFWGqleLwGDoF4GzMtR2vdcqRU1nhRoSbz+eGwk0RFU4MKMXe0ZIMobCoJnIhw85qDvgP4JKdOyNxe05YO4JEMU1Pniqs+9Kq05S/7nnS1pnRvSAbeiUHG0WMh29aCQIlEt5ucrkGnBFIsjYCvp0/jYep91PeKGKmvsEOmA+P/QVxX9Yyi27lTENbFx/4q16kSJp/7Hb+FSfePgvIH9Pw/2mdd6+XkdX9mSrUok6Bm/OMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsJJYknjTnXGyRqEgKnV6qvmK0ALFhZXB2GGvm+ar3g=;
 b=knp9AM2xfWIilPqlMf5bAvxTkuc+ZcexCH+EH48tJaCzk7eqcYdHcvG4Nq+RNWOnua8QVBjpri5PJLQw76C7ZITsNsUsBpBR7VAOjPDVHcEtehL77AWGQK2H8Pd87ZNARIX+EOL08oAl1He5lX4q9w5Z73cbKys63yKVEHfCqHO+M0KQBG6WjGhDDEP6+x+OZj0Yk2MzzPE0ROHpgP3LJl6w6DwGPdGppDHDnNBYQmaTvlnWisxahpX48bvjtu5ZtlgvLvq6jP9Dv6MsWQncQLsBG9AjqPPj0I8xR2Iu5PBOyjpfHOeocyYbg+cKbH9x4yG6EjntepKa83x3tUsfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsJJYknjTnXGyRqEgKnV6qvmK0ALFhZXB2GGvm+ar3g=;
 b=CFRfStqXd8FVXgEuy+u+AhSxMPlg6NH/L8qmMnuvS2wR7r63lWr/N0qobDrXpznvLewKbdGqt7d4JjfUiDK6J5qoCdGjw1WCHL0WXHpPrp6LfsjNrcU/gT8+6QRHlR1Gapo9vmIaJRjrmzrSNsEJBw8uSoD6RcZGQtwGarf98fY=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0910.namprd21.prod.outlook.com (52.132.117.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.13; Wed, 25 Sep 2019 20:11:09 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383%9]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 20:11:09 +0000
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
Subject: [PATCH v2] scsi: storvsc: Add the support of hibernation
Thread-Topic: [PATCH v2] scsi: storvsc: Add the support of hibernation
Thread-Index: AQHVc91eXIfIc+ZZsUmqXD4Fs9njvQ==
Date:   Wed, 25 Sep 2019 20:11:08 +0000
Message-ID: <1569442244-16726-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:300:16::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a84682fc-557b-412a-cd74-08d741f48076
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0910;
x-ms-traffictypediagnostic: SN6PR2101MB0910:|SN6PR2101MB0910:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB0910DF2E71D86B49F71000B7BF870@SN6PR2101MB0910.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(199004)(189003)(102836004)(256004)(36756003)(4326008)(966005)(316002)(7736002)(6636002)(6512007)(71190400001)(43066004)(6306002)(2501003)(107886003)(26005)(99286004)(110136005)(2616005)(66066001)(10090500001)(186003)(8676002)(22452003)(81166006)(4720700003)(71200400001)(81156014)(8936002)(50226002)(66446008)(64756008)(66556008)(66946007)(14444005)(1511001)(478600001)(2906002)(2201001)(66476007)(6436002)(14454004)(25786009)(305945005)(3450700001)(476003)(86362001)(486006)(6116002)(3846002)(6486002)(52116002)(5660300002)(10290500003)(6506007)(386003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0910;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PlDfNWFhIWht7OH7ToLEDRxUb7vstjNuIXMVEaEsomQHe2g28fC/rpMBN2hv/DrZvCf9S5H9uScq/DwBkFvXqfxtE1WXkDIHa3lPiqsBm3ZxUwgt61qJVUNoj2OSakdplWj6pgxgUJ1J2D5vmWwzu4HP1HsqiNCP17ZrL09RYvRSGUbyXmdaL1ZJJUPwElqxcqCMLzPdxvfJiGL9WkjiI63CVq6FxfZ2rbzoT8i0py8gg0wk8u2JBqF5c0Z24NjxFaRyRjmybCm8U4O6nKXtDcGLlbDRjT5txtVXCdQsnDe4X2PWt+16lD2ns2NSvgMtgVfBETaLJSNMxIgVbGRoJEESzRxCtAkrVBMR+Sb96fTli3zzFns0exJpvZcZQsyiG4B2jLFYK8YkUV1wIqSkiPOUQLjrpeqzPltAnDdm95unObbjlrWFCqnCgWem/qqV31KBjQ5qRNNekX/n1UquCw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84682fc-557b-412a-cd74-08d741f48076
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 20:11:08.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MErrASbf8C30NssXuDSJD9UmCspXEjQyISbu6bCHn3VgFK34x0rTBvqsUFzaqKdKkyVqiQgC6JzZTp5C1Ecncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0910
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When we're in storvsc_suspend(), we're sure the SCSI layer has quiesced the
scsi device by scsi_bus_suspend() -> ... -> scsi_device_quiesce(), so the
low level SCSI adapter driver only needs to suspend/resume its own state.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
SCSI tree.

In v2:
	Added Acked-by from Martin.

	@Sasha: I think the patch can go through the hyper-v tree, since
                we have the Ack from Martin. :-)

	No other change.


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

