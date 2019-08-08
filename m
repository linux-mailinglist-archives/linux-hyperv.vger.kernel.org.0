Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36A868FF
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2019 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403886AbfHHSrB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Aug 2019 14:47:01 -0400
Received: from mail-eopbgr1310121.outbound.protection.outlook.com ([40.107.131.121]:9904
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732375AbfHHSrB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Aug 2019 14:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJrsyiHNjzdW7NQuRQZ7AJOhP37DlIjYwSQJqzAZzGysVIevX6E5Dnk7f1QGdmLfrq3EGwHQtNdD83RXjClHIDbZMRk/yWwa5qC/5rfV57mwQwqmJrtLH02p/NqDNiwol5fC3B7kGWQ4H461oTnl4tL+ZuqRYLYaU9inAB3CQIPik0DAVOXlCJ6+FAYeD1UoCpJRbt5xJecxbSQYmkgW92E+KifJylQH4G3XhLH/2Y+n7/WbqY69nZmKeYGjU0WOX6XSXnOcfZujwhkBGkXVeYIhc3LmpZxhRicUJmq8CmFgzOTe7/uFQGAWfm07GcVD1aTdiSTXpMvlYkRGlElyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAYZ9dU/6i43zinEBNLIgVH26s9PLsv6Sw+MgVWb2Vs=;
 b=isN/4dxZtIUd/FRzvLl5TvpJLqgtnw3tTRmVxsGpZIqkluMn9aoAi03EKjGYi19cI0w1sfK3fwQgeG0IoMDyRoA/gAeFewVL2Lleoj7KIhEldTiQKpIYoeUgYhMT4oexi3va2fWb5Gg0KXozOxFt2Uywvw2vLu+UhKETLwimD3tLxGmuXm8XoWInPB+ZTLQEfgJ8QH7WCyT9ODWoWW31RjMVihXDLZwB84H3ExuJnWPkoHAnZCmTjR78VS+2HcvQGHAAAZhUFsJKzjjPjBMCfS9pgHscGIqVcr8wczpxIDoerkG3hnR34wnnS7dcHGh91nHpR60Ct2fhQ4X35lfC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAYZ9dU/6i43zinEBNLIgVH26s9PLsv6Sw+MgVWb2Vs=;
 b=HMR3R7vEFAYhOr78oSybbVE5JDELJhtUDl4v4fw+xVsF/SE9uMjOM03iIN11CHZVAzw7LTSjSit9YYzRze8fkfgGZid8+6GgBS03scTgMnfEYkaDHJ/SfT/fHB69eChOzEGiAcJ94xu2KVp8LRVrTjb9MbUcG+4Z3IH1+bwpbb4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Thu, 8 Aug 2019 18:46:52 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%7]) with mapi id 15.20.2157.001; Thu, 8 Aug 2019
 18:46:52 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] PCI: PM: Also move to D0 before calling
 pci_legacy_resume_early()
Thread-Topic: [PATCH] PCI: PM: Also move to D0 before calling
 pci_legacy_resume_early()
Thread-Index: AdVOGUCbZsj/msiiS0u0Knw2VZMQCQ==
Date:   Thu, 8 Aug 2019 18:46:51 +0000
Message-ID: <PU1P153MB01695867B01987A8C239A8CCBFD70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-08T18:46:48.2777075Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=be1244be-979b-4200-b7ec-5143529e7577;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:c9ac:49d6:29e2:b6ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df167415-44af-49aa-ab1a-08d71c30c734
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0121;
x-ms-traffictypediagnostic: PU1P153MB0121:|PU1P153MB0121:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB012181186D53E3474FD4698EBFD70@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(46003)(66446008)(25786009)(66476007)(64756008)(86362001)(10090500001)(4326008)(76116006)(186003)(7416002)(52536014)(5660300002)(102836004)(8990500004)(66556008)(53936002)(14454004)(476003)(486006)(74316002)(6436002)(99286004)(66946007)(55016002)(7696005)(9686003)(6506007)(2906002)(8936002)(316002)(110136005)(6116002)(107886003)(7736002)(14444005)(8676002)(81166006)(478600001)(2201001)(305945005)(10290500003)(81156014)(256004)(33656002)(71200400001)(71190400001)(22452003)(54906003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /JHIWFta4PfsRbw/Jk3xSNmDMWwGASoySf78YgUAenBImPB6mFhGnlo/RU7HLCsnLoIec0d8p0VE9MzLPz8jMH6R/yxiqN6yvRMrB0HJ9y24CRgrZpBVhR5KsyERweRIRGoD5+gqDZhu2KnclzyVy///5OeyNKqd1VrxIYAoMDYw4jMyXi1VLY0OdFYm9WdqNhlZgNLmakSddCTrryKr5Cw/YoffC6wJrVIovV2tFAKk1e06e1mU1VZ/IWu1nLSyQaptnQRVP+IidMHyeoyXbQy2mDn46PIDDz5D1z79EbmKi4U1Go7qIGsrKxF1nWmw+fPb2htmrUUAhH8Lo9EWrwCOWxqrrjunOtqNkT+VEriwAFRRGFeNhC17MrPNCHcBJV58BdZ/10WWnSoxZPo1VWUFhl5o474OB6Sd7SVHp5k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df167415-44af-49aa-ab1a-08d71c30c734
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 18:46:51.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ko4yk4r0jcGFa03WVn8FjOxo/mMATvFzm0ukzXlyDp0d7PKBSHITSB9j0kOtZ7nG34WhfuuQg/epL12NZ5jVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
but the current code misses the pci_legacy_resume_early() path, so the
state remains in PCI_UNKNOWN in that path, and during hiberantion this
causes an error for the Mellanox VF driver, which fails to enable
MSI-X: pci_msi_supported() is false due to dev->current_state !=3D PCI_D0:

mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
mlx4_core a6d1:00:02.0: Sending reset
mlx4_core a6d1:00:02.0: Sending vhcr0
mlx4_core a6d1:00:02.0: HCA minimum page size:512
mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode, abort=
ing
PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
PM: Device a6d1:00:02.0 failed to thaw: error -95

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/pci-driver.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 36dbe960306b..27dfc68db9e7 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device *dev)
 			return error;
 	}
=20
-	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
-
 	/*
 	 * pci_restore_state() requires the device to be in D0 (because of MSI
 	 * restoration among other things), so force it into D0 in case the
 	 * driver's "freeze" callbacks put it into a low-power state directly.
 	 */
 	pci_set_power_state(pci_dev, PCI_D0);
+
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_resume_early(dev);
+
 	pci_restore_state(pci_dev);
=20
 	if (drv && drv->pm && drv->pm->thaw_noirq)
--=20
2.19.1

