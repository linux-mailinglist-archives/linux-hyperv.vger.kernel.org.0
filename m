Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9AB0609
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfIKXi1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:38:27 -0400
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:35718
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727659AbfIKXi1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX/ULtzYVh72pt9xJmNZOx52cvA8TIvOIb1xej5Ht7R3DTUqNzpS9JtKv/Loj/Y5I3XhXwnpIw3EAv0PZ64TBI9NjfL0etxqhDyGTM+UtIVCwOOTwo1B7lYVexNMW7xNJaZi6t95Kv4aBS0NcrGgLULED+Z6AQ2XwYrTnJqx1b0h7FgBT12fcWRfcPkdew1v7ob3f443Uck+8pjJSRglwHQ13/yHO2TuHfmpPNH0DVtaJFNSthDivBi1VcXfXkghH2NDhSKkUVfLTbY/JYmuDe8V5E81ReD38nfeZ68MoW258g2GrGvo3B2E2ImJNdLuJl3E33Z+F4u3+XDdyQFHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUwVSOOzmPB8yKg//uWeoY+txIH+PriwlUrZ5oaqjZA=;
 b=k+fvA0DgKWIbLP9+eckJ0Gj1NTN6SU6CcV6usGAPOT55NX8wZSYFBqQQrNJ/aWnmv8kLqckPrd1sbnkemXU9pcDlYiu150SUp7xNcJPovGUCkyIWeFAdqj4L53fGDZrnTa0GRxolEpdnbuzhd4wi3j+jlFLuaU98l3h4hKvVChIeieqZ2ATWbDlQ+bqObbk3WRJz3ehSeOw8aRU+4ExZ/IlAXBU9rPwdpMM0+J9WOobVIHASVwlhS+yMOqm3UXinqcYIdAd9z1l1spz1ae0p36Ws6n4BSi6HvTPE2z/qBGZgIsARlWMAKlkQjm89XknBGNNvb1WbqyNvB/mcJm2Aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUwVSOOzmPB8yKg//uWeoY+txIH+PriwlUrZ5oaqjZA=;
 b=YpA5Db8JZfKeB/1Az/ie0Ecde+dy4MfiOwrIpRI0ipajqLiXta9NQ9bfFMNqLdDa30N8DRBGUMvgH58sNCGXs/4KjaWDRLTR8OJdIZ2KGsn/eijjEX6YZUFj1K3H9vFMe6dRD7pNqSFZhLNUXQ8+82h7FQclTJMwGUPdBdv9PUk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1087.namprd21.prod.outlook.com (52.132.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Wed, 11 Sep 2019 23:38:22 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 3/4] PCI: hv: Do not queue new work items on hibernation
Thread-Topic: [PATCH 3/4] PCI: hv: Do not queue new work items on hibernation
Thread-Index: AQHVaPn/cNR9IJtpNE6TYmXuPOiYYQ==
Date:   Wed, 11 Sep 2019 23:38:21 +0000
Message-ID: <1568245086-70601-4-git-send-email-decui@microsoft.com>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568245086-70601-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd5d5c12-31ae-4993-51f2-08d737112181
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1087;
x-ms-traffictypediagnostic: SN6PR2101MB1087:|SN6PR2101MB1087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1087CACBC43CDF12BE7FF77ABFB10@SN6PR2101MB1087.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(10290500003)(11346002)(2201001)(2501003)(256004)(7736002)(6436002)(305945005)(2906002)(14454004)(3846002)(2616005)(81156014)(81166006)(8936002)(50226002)(66066001)(26005)(8676002)(5660300002)(110136005)(6116002)(316002)(6512007)(66556008)(186003)(66946007)(86362001)(446003)(66446008)(6486002)(64756008)(66476007)(22452003)(71200400001)(476003)(71190400001)(107886003)(43066004)(25786009)(478600001)(14444005)(102836004)(6636002)(99286004)(1511001)(36756003)(4326008)(486006)(76176011)(53936002)(52116002)(3450700001)(6506007)(386003)(4720700003)(10090500001)(21314003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1087;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QBXfQXg4zjNvIilfHYTnCyBEftJhpenT+zazlYDQ40yq03UzBImzHs7Xuulri69DsQCmynzITeHD77yoAd7fa3cMq2U9LYIJHfYxvTaq3/0FADhKx4AKtFYGEHxFaOtLyWsnanDAr5Q1cJz1iSWDnihRl+J7nwleFVik+5ByDP5/a9xAjQRmSJj1SWbSm94JI8vd1+5qDfZevd6crsZF5UYJ+NdXJ6Jmm7iPQPxWDF6HrwkbDnVsYmZnaXX7KidhZ+TNLcGEEJZsRPONzMAIYVrOaSZqM8U38xhYFgVMnYujoscipfpzNW/FWXMiaSmSICkkmZeQ3VpD8XHCWYPqLtfabmjbnJmRShJvtxOD980kMcs+JK6h+WEqfWl8WX025YrbYZlbA3UODd5uTWq3+PGF3TYA3ZprALJkSbJHdHo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5d5c12-31ae-4993-51f2-08d737112181
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:21.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/6Wts2uDJRFdziV2cCVrDMvQ3CLOvijdWUYeuUexpgIq4O/C7QC3V9E7FcYnGsfYeJ7hTkeTY7ocL72VA6ITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1087
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We must make sure there is no pending work items before we call
vmbus_close().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 3b77a3a..2655df2 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -422,6 +422,7 @@ enum hv_pcibus_state {
 	hv_pcibus_init =3D 0,
 	hv_pcibus_probed,
 	hv_pcibus_installed,
+	hv_pcibus_removing,
 	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
@@ -1841,6 +1842,12 @@ static void hv_pci_devices_present(struct hv_pcibus_=
device *hbus,
 	unsigned long flags;
 	bool pending_dr;
=20
+	if (hbus->state =3D=3D hv_pcibus_removing) {
+		dev_info(&hbus->hdev->device,
+			 "PCI VMBus BUS_RELATIONS: ignored\n");
+		return;
+	}
+
 	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
 	if (!dr_wrk)
 		return;
@@ -1957,11 +1964,19 @@ static void hv_eject_device_work(struct work_struct=
 *work)
  */
 static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 {
+	struct hv_pcibus_device *hbus =3D hpdev->hbus;
+	struct hv_device *hdev =3D hbus->hdev;
+
+	if (hbus->state =3D=3D hv_pcibus_removing) {
+		dev_info(&hdev->device, "PCI VMBus EJECT: ignored\n");
+		return;
+	}
+
 	hpdev->state =3D hv_pcichild_ejecting;
 	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
-	get_hvpcibus(hpdev->hbus);
-	queue_work(hpdev->hbus->wq, &hpdev->wrk);
+	get_hvpcibus(hbus);
+	queue_work(hbus->wq, &hpdev->wrk);
 }
=20
 /**
@@ -2757,9 +2772,21 @@ static int hv_pci_remove(struct hv_device *hdev)
 static int hv_pci_suspend(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
+	enum hv_pcibus_state old_state;
 	int ret;
=20
-	/* XXX: Need to prevent any new work from being queued. */
+	tasklet_disable(&hdev->channel->callback_event);
+
+	/* Change the hbus state to prevent new work items. */
+	old_state =3D hbus->state;
+	if (hbus->state =3D=3D hv_pcibus_installed)
+		hbus->state =3D hv_pcibus_removing;
+
+	tasklet_enable(&hdev->channel->callback_event);
+
+	if (old_state !=3D hv_pcibus_installed)
+		return -EINVAL;
+
 	flush_workqueue(hbus->wq);
=20
 	ret =3D hv_pci_bus_exit(hdev, true);
--=20
1.8.3.1

