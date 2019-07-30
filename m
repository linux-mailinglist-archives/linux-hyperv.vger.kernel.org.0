Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD17B64A
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 01:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfG3Xio (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 19:38:44 -0400
Received: from mail-eopbgr780100.outbound.protection.outlook.com ([40.107.78.100]:28086
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfG3Xio (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 19:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWeI4sso1xOSztpzVblzcBN4TA6hBODadL/ZSkPAROPOh+FTxc0OXdKEHtBBUU8KIwvAEsShE4f++LAPztq7wgdf/TjxW+kLdRIKmxaWleed9/xW0gSLtD3wCAnKXet3bDuG7gYFtSNClIbBFHEdBCecmKOC87MxK1rXDfVF6vosmRWNwVLiDtxHk0fdeWlVSoi1TkilKe5s7oMfo1PzLZ+N+5Aef1yWuJsjJohAs6ntLFAkcEs76bK/Rv6ol6mrIaWQnhjuk/ed607wl5VPqM7FSCCuCb5QUckjBqgs92KaoXEDDFR2Ak7xHkJq4cMnmS5DtF94O51aUmyuLkK1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxKMHa9Y6JHFrjdvmcHiaakWoceGKp/pzlEJzkPojkM=;
 b=izutVAEv/XFCEtzc+m40+l3PprjMSvcytDhnVQn2H42e6gjm/p1j6jTRd5TUAksVcevze2vXIPKVgUVbC2v719IAiUhNu/ja8rEhCroeCG6F/A++nSEp728oGNuUUGfibT06I1+o6j+OfZM94xyMHFz54Ci0zlgzk5Xfz0Ll/jipN3mhP1u7Kc4Pakw1T8tr01J5Q3wm+S/NifISUXONGtBD2ZgDJaUdKoTQFpvPjpg1nM5uJNZXWwzMB8X0bL5gagNdnHSKNg/WKQaojq+XK5VD7O7Chnh1f8ybz+Periw+cptHK8/0uUs6gxZACirXLXpHpD47iwjF/fWp3Ij4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxKMHa9Y6JHFrjdvmcHiaakWoceGKp/pzlEJzkPojkM=;
 b=RrcYQRo4+Q0B9gyulaIuecweXmG9diG3v2qwAmTgOJ11lilbAuumI2a+KganddZHSO7VCQalHrM4C9u3txs4nN/1WEkCs2T0jWGyfW/yyzjS6GX4D1zcj7vbrLwRgJ7IE2c1QmQORIG7Y3alQooodi1iBJeniO+3AHo9eJQdmGI=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0781.namprd21.prod.outlook.com (10.173.51.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 23:38:40 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82%5]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 23:38:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/7] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Topic: [PATCH 7/7] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Index: AQHVNhdJKDvkQYIeSU+yCMo/OcKIhKbj84Ew
Date:   Tue, 30 Jul 2019 23:38:40 +0000
Message-ID: <MWHPR21MB0784488C028A69D1E416E4A0D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-8-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-8-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T23:38:38.5348418Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a36885d6-266c-4550-bec3-9bccdf61cecb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0a73869-4c75-46bc-ffd3-08d715470d41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0781;
x-ms-traffictypediagnostic: MWHPR21MB0781:|MWHPR21MB0781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB07814253A0F8E7A85F2E16EBD7DC0@MWHPR21MB0781.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(33656002)(316002)(256004)(99286004)(14444005)(5024004)(8936002)(81156014)(22452003)(6436002)(68736007)(8990500004)(53936002)(76116006)(9686003)(110136005)(81166006)(305945005)(14454004)(25786009)(2501003)(55016002)(10290500003)(8676002)(74316002)(66066001)(478600001)(86362001)(1511001)(71200400001)(6246003)(71190400001)(476003)(26005)(102836004)(76176011)(2906002)(6116002)(7696005)(6506007)(3846002)(446003)(2201001)(5660300002)(10090500001)(486006)(64756008)(66556008)(66476007)(4326008)(186003)(15650500001)(7736002)(52536014)(66946007)(66446008)(11346002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0781;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tsPTam7MM8amLxj40j+T8Dr/fR0X4jgdzElJSX2AICJxLUKP6/Qdu069aMPAilwlUnlV/P9DdWuQ28okFRtZfPTg+0vRt4RSiajQljIKrQEuaqofnEFMN0kcgTV3YezLsH7gQ3Gy6qtDUOB1m561+PALj4SBTnpsAHmuF4h4UloUW6MWBS0ikc1J15XpTC0HjwDyaJ9rcTizNKdHEkuJCpCojfSEjk72jEuidKg3mtYZSUdhxnFod9PCEGnXei+sd0F0F42HjIBDaxbuokf2fQvXj6Gpjdq4QxkFabIaIf4QW93kvMgPLIbpkuqWoaqKNEZ+h8rEWk08JH0UyBrzialBATXrsnah/zGXU/BWI88aV5bi6maPxiCXTAHN9IebSAy2z4vh553h9v+USNF/gmIMN5pLH5vbLrOUzYme7CE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a73869-4c75-46bc-ffd3-08d715470d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 23:38:40.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpZFFgcYX6t13PhBcrY6S2SHbIojWwYT6ctgFgohIsTISMlV53Orq49tKQ66qiRn5seF5FK/QJjBqValam9tY66G4Gu5tFqBv7J5uMHHXew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0781
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, July 8, 2019 10:30 PM
>=20
> The high-level VSC drivers will implement device-specific callbacks.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |  3 +++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1730e7b..e29e2171 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -911,6 +911,43 @@ static void vmbus_shutdown(struct device *child_devi=
ce)
>  		drv->shutdown(dev);
>  }
>=20
> +/*
> + * vmbus_suspend - Suspend a vmbus device
> + */
> +static int vmbus_suspend(struct device *child_device)
> +{
> +	struct hv_driver *drv;
> +	struct hv_device *dev =3D device_to_hv_device(child_device);
> +
> +	/* The device may not be attached yet */
> +	if (!child_device->driver)
> +		return 0;
> +
> +	drv =3D drv_to_hv_drv(child_device->driver);
> +	if (!drv->suspend)
> +		return -EOPNOTSUPP;
> +
> +	return drv->suspend(dev);
> +}
> +
> +/*
> + * vmbus_resume - Resume a vmbus device
> + */
> +static int vmbus_resume(struct device *child_device)
> +{
> +	struct hv_driver *drv;
> +	struct hv_device *dev =3D device_to_hv_device(child_device);
> +
> +	/* The device may not be attached yet */
> +	if (!child_device->driver)
> +		return 0;
> +
> +	drv =3D drv_to_hv_drv(child_device->driver);
> +	if (!drv->resume)
> +		return -EOPNOTSUPP;
> +
> +	return drv->resume(dev);
> +}
>=20
>  /*
>   * vmbus_device_release - Final callback release of the vmbus child devi=
ce
> @@ -926,6 +963,10 @@ static void vmbus_device_release(struct device *devi=
ce)
>  	kfree(hv_dev);
>  }
>=20
> +static const struct dev_pm_ops vmbus_pm =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(vmbus_suspend, vmbus_resume)
> +};
> +
>  /* The one and only one */
>  static struct bus_type  hv_bus =3D {
>  	.name =3D		"vmbus",
> @@ -936,6 +977,7 @@ static void vmbus_device_release(struct device *devic=
e)
>  	.uevent =3D		vmbus_uevent,
>  	.dev_groups =3D		vmbus_dev_groups,
>  	.drv_groups =3D		vmbus_drv_groups,
> +	.pm =3D			&vmbus_pm,
>  };
>=20
>  struct onmessage_work_context {
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 6256cc3..94443c4 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1149,6 +1149,9 @@ struct hv_driver {
>  	int (*remove)(struct hv_device *);
>  	void (*shutdown)(struct hv_device *);
>=20
> +	int (*suspend)(struct hv_device *);
> +	int (*resume)(struct hv_device *);
> +
>  };
>=20
>  /* Base device object */
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

