Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028CA85654
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2019 01:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfHGXJT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Aug 2019 19:09:19 -0400
Received: from mail-eopbgr1310127.outbound.protection.outlook.com ([40.107.131.127]:7616
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730045AbfHGXJT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Aug 2019 19:09:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVPQBitlct+SY61+UJ520X2VS3jTuq2YM1ABsVVQ6bFNVnmjI4wobi2TU2V814oABLZVhf8BMk6jzMmgjZQdwqE2AN4MFayjz1zv90Kj/Z5AIjQLQkI3C1rw1Ev7bVjRJoPWGbYLKQ/nRP+Bs67V8TaCpBrTsCRW4srTGI6k2nP13QgkNs/6Oe1EPZ3wFTHDfrlJ4elX2VUGbZReMlfVIOawp+EVcsrFqe/5pVnqW7pjZ0WGo45nlLu6uboX1E+W3a3GOx/95vLqhAQB8FmEUUSL/xCgVSiIWP9qlJaa5JD9CgNYMECTPkOwLXhFMBPIdyfj1aWI9e+rv598grCC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3736R5XI6RqQxT1T7d8oJzVjxtaznrze4mwemG3zp68=;
 b=j3fwtyyIrnXo4FsGIm8ttvQHI9aBoagJjs87NWFm7yTxTNPl4XcooyfFoW/Dq0fKVLLjRxf78UpxNfnv/JYMcuxY82MCalIxrTLQODfg4STZCD/CeJkiIp45pfAPk4COlFbGHDNWIXaQBifSzfsywd7CxbQwJcpRSwI73RzRcE7UzcZoeQyf7AMhkjBbM4iaryAS48RyI9sQptyPosRD4ZxTRDNjPLOg/KVS0QgmMrIrJ68OnDivovMJuURHadwC2zoXlLqTk4CYa/z+meBsO0hNJPlS25rlU53KUpeUc+fZ96TO0QJYxe1SEAsQuw3t9DQ4MqHNdt4a2leYqp1WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3736R5XI6RqQxT1T7d8oJzVjxtaznrze4mwemG3zp68=;
 b=mJ9tchdSjqIp0brmuaY/CulopE3qNd/RM+fASXeo94XnEiXYY/A3EZ6l6R9q8WIf8xXHKvABG/4aHLsoQIwA9JCkqeCbR2+CyU/yKDFv0OEPPmvSAZN4D/agzUvwPJ8qly+cmEnx6PqPH3GvSY/oUyFl11V9L2VGMBcPw9zjBrg=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 7 Aug 2019 23:09:10 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%7]) with mapi id 15.20.2157.001; Wed, 7 Aug 2019
 23:09:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Topic: [PATCH v2 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Index: AQHVR8it5keYZQsWuEumlWhe6zeYwabwVjjQ
Date:   Wed, 7 Aug 2019 23:09:09 +0000
Message-ID: <PU1P153MB01694BCFC735D4F625AB5E88BFD40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
 <1564595464-56520-7-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-7-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-07T23:09:07.6237200Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4e858d71-0d86-400a-8da7-9aae3bb7ae09;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:e6c:c99b:1717:c966]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93994cbd-60ff-49d9-886c-08d71b8c4167
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0156;
x-ms-traffictypediagnostic: PU1P153MB0156:|PU1P153MB0156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0156FA0B09F4C4D955DDD446BFD40@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(189003)(199004)(66446008)(10090500001)(22452003)(256004)(305945005)(53936002)(14444005)(15650500001)(66476007)(8990500004)(66946007)(4326008)(2906002)(10290500003)(316002)(64756008)(478600001)(1511001)(55016002)(66556008)(14454004)(9686003)(7696005)(7736002)(5660300002)(6436002)(110136005)(6246003)(76116006)(52536014)(81156014)(476003)(46003)(8676002)(74316002)(2501003)(6506007)(99286004)(33656002)(102836004)(6116002)(81166006)(486006)(86362001)(76176011)(53546011)(229853002)(71190400001)(25786009)(8936002)(71200400001)(186003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UqxVCerTv4s2L31lV8oOuCPff3ZaiWbYfhUwc3os+KicDyJpNF9o59RzRqyCiaEp0KCSPKLuRo/g5SGhg6x7yDTxsB7mE4GmRHwWqzp8/6mSQ8/Tdt9zRUdV4eXnh7091Dg4mVNUHUQrgj9aCIqoef8kF4jRWajPjWi8khIQ7GA41g10t6R2CSZh+ciGm8VPfh9i8k48HaWxwJuC66z4yE8UbNRUuxDEzJYgYYapkZgf9DZ3Kz1dEYfngDbcKFI/OhtVVK0aEuwVCsp9TQ3IFM9xypjqyonJre7y9sFerv2slrwMPDsGsJbWu3e0ZpEyJFsymthYTSw2GnWnROSmbfENrzI/nEwxxTVSntdcmhvzpdI4DnGc3Gtvjaq2PX3G9G94/2sU7fw5M4dR0reJDnD+5I0mks1pQphbShpb0J0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93994cbd-60ff-49d9-886c-08d71b8c4167
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 23:09:09.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RR1Yj1S677//dX/3hp7Q6dagao+Tnobl1xUMBI36Z8K9/QPM55sBwJDnQ+mL2fjTUIZkbPM8qx9g5R5isnszKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, July 31, 2019 10:52 AM
> To: linux-hyperv@vger.kernel.org; gregkh@linuxfoundation.org; Stephen
> @@ -2050,6 +2095,10 @@ static int vmbus_acpi_add(struct acpi_device
> *device)
>  };
>  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
>=20
> +static const struct dev_pm_ops vmbus_bus_pm =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(vmbus_bus_suspend, vmbus_bus_resume)
> +};

It turns out this " SET_SYSTEM_SLEEP_PM_OPS" should be changed to
"SET_NOIRQ_SYSTEM_SLEEP_PM_OPS" to make NIC SR-IOV work with
hibernation.

This is because the "pci_dev_pm_ops" uses the "noirq" callbacks.=20
In the resume path, the "noirq" restore callback runs before the non-noirq
callbacks, meaning the vmbus_bus_resume() and the pci-hyperv's .resume()
must also run via the "noirq" callbacks.

Similarly, I also need to make the same change in this patch:
[PATCH v2 7/7] Drivers: hv: vmbus: Implement suspend/resume for VSC drivers=
 for hibernation

BTW, I'd like to change the print_hex_dump_debug() to print_hex_dump() in t=
his patch:
[PATCH v2 5/7] Drivers: hv: vmbus: Ignore the offers when resuming from hib=
ernation

print_hex_dump_debug() outputs nothing unless we enable the dyndbg.=20
This is not good as we do want see the error messages here, if there is an =
error.

I'll do more tests and post a v3 of the patchset.

Thanks,
-- Dexuan
