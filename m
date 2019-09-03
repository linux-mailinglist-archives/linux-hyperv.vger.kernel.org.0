Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A97A5E9A
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfICAeq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:34:46 -0400
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:35381
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfICAeq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkXwnH2QTF20bE1g/GWKBc2BEI2yrZZqfqAU3z1E4Tps2Jkc8NvU9gBKtiMQk+md0LB3CsDjyRXvPA+G+eoKmDQs1Y1PD9YfeGbtNxRUzwWV3AK+ixLogHpaogF5zWA249pdH/GOHYFI8C5OoGtt7eFfTJpvSAIg8qm9cX2Nra6D/5DWykOm+SFk61shdv9/Oe1Ag4JLXfZSkp/0D3OKtM/H3ISXhvwt28ZsE5H8Pj+RK/WdALhsgJc+3f/S/DDTQTpIxaKQ3ycGscQUkk5fOrWGMsF5NsjkD4GdeOwH7yotXyb/veUkos58VfYX14FqXcd/HL7Ja07M6DL0hJrpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhz1An8bmEF08N3HCpOEWBQd4f+18ZJ30Kh87oDetCk=;
 b=jsBYeJ5s+cJNgxu53zhDOx/Y4foIGbVDeYU/uZU8cF4RQAkPPfMg6fIkbjMEJbR9wNgmE5IMxozb26jlOqFdSZ1OOdt56PUetTNneVaEyY6F5cRP4dioSNTIb+bBIGDUbK1lJ0v1mom26fQZra2sx8LvQAMo2fr1GbUk19tG0XszJZ/jSadodOZfMvkC1RHi2ZIBQEQgNOsrSQLnnoh/BrW33l20DBBsNN4tI81RByaYMhgTdmoiZfD3Ql6uXy5Yc+Y+Xq08a6VYXkbtyqPXwKk7mFpCg4kkP32LsGJN6xkkVtq7S1/45bOpc02AGLnXmoFH+CN5BC1QPNbmOjuI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhz1An8bmEF08N3HCpOEWBQd4f+18ZJ30Kh87oDetCk=;
 b=f3oSBmbpKVsewQ/3SLkkeYb8oDgUCiUfmGCX9EGT6ZwW/gVUnifqm1+0moNNA0u5Cz+yzzfKPMC7RQIAwGcox/UCydAJLQmXl1NREB5A8yfDT3ERA+UfLRnNjKSokGb8inWHkowVYdPKcyzxyRJQAcqxaoh5pwWZ7IvXGh8SBQg=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0135.APCP153.PROD.OUTLOOK.COM (10.170.172.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.1; Tue, 3 Sep 2019 00:34:31 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::f112:af3b:a908:db07]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::f112:af3b:a908:db07%7]) with mapi id 15.20.2263.004; Tue, 3 Sep 2019
 00:34:31 +0000
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
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: RE: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Topic: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Index: AdVSPER5d22rbcvgTV28JV77HSffhgPsqanQ
Date:   Tue, 3 Sep 2019 00:34:31 +0000
Message-ID: <KU1P153MB0166994305CF5B9CFA612AA7BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-14T01:06:51.2322584Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab25360d-4a75-4436-9390-ec9b2f112f8b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:45b3:904b:db76:f1a7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6d042a3-3053-44f3-551a-08d730067cb8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0135;
x-ms-traffictypediagnostic: KU1P153MB0135:|KU1P153MB0135:|KU1P153MB0135:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KU1P153MB01352A5EB3C3370A69F87395BFB90@KU1P153MB0135.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(54534003)(476003)(229853002)(8936002)(478600001)(33656002)(9686003)(81166006)(81156014)(53936002)(6436002)(76116006)(66946007)(71200400001)(71190400001)(8676002)(2906002)(2201001)(7416002)(6246003)(305945005)(14444005)(10290500003)(55016002)(316002)(52536014)(14454004)(256004)(22452003)(99286004)(5660300002)(4326008)(25786009)(8990500004)(110136005)(54906003)(6116002)(74316002)(46003)(186003)(86362001)(102836004)(66556008)(66476007)(66446008)(64756008)(446003)(6506007)(2501003)(10090500001)(486006)(53546011)(11346002)(7736002)(76176011)(7696005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0135;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j8sULtPSLpIJEtVb3s/JVvvJcFkW62CpVZNgEq75naYn+6uZmmc8ILl+/KVReNXQox/QBYSrb+rYuoRP4BYaib53EcYZL4U6yY9TSaQZZMi6yw+AsQeBQGLmso6bxqRA2b+DNpehu29Tl293FAzRGWBwqkBHat9XT6y/dDEZGS3x8CWQyNplU7TcAl9f73D2cWQnlxgJRBtmpWQ+YrvalWKYaUPtWb/AHnnYQc/M6APvCnW/2QRSbp/OJpJgYTG1ffbmyY3ZzwwI8ZSBj9B+E++NILkneL3gmZkq23YJvlowvTZ81i11JIgdeG0ZV5jZbKXMXdEoNn3ltil2Vq1goQpInIjEq0F3KfH3ckKY3ZhVVonFOjh2bJJXLFQJCdsuXmrNNo3ETRqwEwQ1ZxVHQl/EWRcIson1aejMzi4J/TU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d042a3-3053-44f3-551a-08d730067cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:34:31.1039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7YM1tYxy59yq3E99tTEKZNVFr49g55VxDE7TjUiHSv5ZKmmNY3yLWesJ8n2OMAC6oGNlm8S+a4GH4O5gqQn8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0135
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Tuesday, August 13, 2019 6:07 PM
> To: lorenzo.pieralisi@arm.com; bhelgaas@google.com;
> linux-pci@vger.kernel.org
> Cc: Michael Kelley <mikelley@microsoft.com>; linux-hyperv@vger.kernel.org=
;
> linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Sas=
ha
> Levin <Alexander.Levin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; vkuznets
> <vkuznets@redhat.com>; marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>; jackm@mellanox.com; Dexuan Cui
> <decui@microsoft.com>
> Subject: [PATCH v2] PCI: PM: Move to D0 before calling
> pci_legacy_resume_early()
>=20
>=20
> In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
>=20
> In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
> but the current code misses the pci_legacy_resume_early() path, so the
> state remains in PCI_UNKNOWN in that path. As a result, in the resume
> phase of hibernation, this causes an error for the Mellanox VF driver,
> which fails to enable MSI-X because pci_msi_supported() is false due
> to dev->current_state !=3D PCI_D0:
>=20
> mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
> mlx4_core a6d1:00:02.0: Sending reset
> mlx4_core a6d1:00:02.0: Sending vhcr0
> mlx4_core a6d1:00:02.0: HCA minimum page size:512
> mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
> mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode,
> aborting
> PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
> PM: Device a6d1:00:02.0 failed to thaw: error -95
>=20
> To be more accurate, the "resume" phase means the "thaw" callbacks which
> run before the system enters hibernation: when the user runs the command
> "echo disk > /sys/power/state" for hibernation, first the kernel "freezes=
"
> all the devices and creates a hibernation image, then the kernel "thaws"
> the devices including the disk/NIC, writes the memory to the disk, and
> powers down. This patch fixes the error message for the Mellanox VF drive=
r
> in this phase.
>=20
> When the system starts again, a fresh kernel starts to run, and when the
> kernel detects that a hibernation image was saved, the kernel "quiesces"
> the devices, and then "restores" the devices from the saved image. In thi=
s
> path:
> device_resume_noirq() -> ... ->
>   pci_pm_restore_noirq() ->
>     pci_pm_default_resume_early() ->
>       pci_power_up() moves the device states back to PCI_D0. This path is
> not broken and doesn't need my patch.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> changes in v2:
> 	Updated the changelog with more details.
>=20
>  drivers/pci/pci-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 36dbe960306b..27dfc68db9e7 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  			return error;
>  	}
>=20
> -	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_resume_early(dev);
> -
>  	/*
>  	 * pci_restore_state() requires the device to be in D0 (because of MSI
>  	 * restoration among other things), so force it into D0 in case the
>  	 * driver's "freeze" callbacks put it into a low-power state directly.
>  	 */
>  	pci_set_power_state(pci_dev, PCI_D0);
> +
> +	if (pci_has_legacy_pm_support(pci_dev))
> +		return pci_legacy_resume_early(dev);
> +
>  	pci_restore_state(pci_dev);
>=20
>  	if (drv && drv->pm && drv->pm->thaw_noirq)
> --

Hi, Lorenzo, Bjorn,

Can you please take a look at the v2 ?

Thanks,
-- Dexuan
