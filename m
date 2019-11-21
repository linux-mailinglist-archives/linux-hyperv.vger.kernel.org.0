Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECE61047B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2019 01:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUAu0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 19:50:26 -0500
Received: from mail-eopbgr1300117.outbound.protection.outlook.com ([40.107.130.117]:2706
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfKUAu0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 19:50:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRiy1E9aIjy61X6MkvU6FoO87di8/K+7NccbOTJ8KA3W/+qnipnxgfEz0OW+nOXfLps6FHMnK3gkBvTtXTvIwBy7yXZzXr3r6796vhan9VFX9ViQI1eGDGBb1NQwk6tubTBcShDURquwq92qHW2C4g2NFF2ifVGGeYGSalFXlwBcH0TG1n11ucuzIFw5NkT92yQD+JgsMVvbqs3jyTAwTvEqT0uAxmjDUFD/egd+n1CUJ19nKYAwwSPG5wdcarTiaSF5A/UGe8s8V1m7i/1mhQkDNUZ7I0O4XHA8vc+wwis6pREpU/+lNBD8fG2RqXmbtc6VTtFek3eg1mO2sYcxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP/wLcVOsTGzmUvaHhnBHvrW+nZ25FO5Vy0wDWKrMHI=;
 b=cmmFm6X/MpEpvl1F+MTQheD9TPfdH4dixVtWRD4JcBRED/6N1NZInmCTAYqhzpOU2WmoY1tFtCsqbBrZLZxLfB4P3GCtYdQs4mxqwtyGFPf/fQkN/YywbUPZdfkz7K6kNklHPTf54nPvu9mA5qpGksLbovn5Gzn+InKBoH6H4ZRIcuQyAE1BqlvUUb31FWC5qxSwuneIfN0xThM9QLb7/StgarCc/MDS9CI6u/FkNwurQa3TW68P1dWqULoK2f0NAo1zCP9t3tjzCpVErzq82s3hs0WB+0vm0tKtuannBY1pxPIQ6qEzKNIUrjqh4u+Qmd+ikANuCIRd84+sPxM73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP/wLcVOsTGzmUvaHhnBHvrW+nZ25FO5Vy0wDWKrMHI=;
 b=KF8mPjNDudM4eUged7Li91wDu0PdcPjyeYv4mrjw7UK6Spj5p9HHGZGwBFtdJ24rDVLFw4w6SI9eCXKgYk393P/aZxEhg4kMk5n/svxvL103VP0dkLTp8+slPcebZ7A8swi4vXM8RVamYQfmhNRz6NuOb5TPSXkqns9XQq6mU24=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.0; Thu, 21 Nov 2019 00:50:18 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2495.010; Thu, 21 Nov 2019
 00:50:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Thread-Topic: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Thread-Index: AQHVn8bS/DqK5/y4PU+iJ9zuKs55jqeUwW9Q
Date:   Thu, 21 Nov 2019 00:50:17 +0000
Message-ID: <PU1P153MB0169D0A99D5687FBDB02536BBF4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-3-git-send-email-decui@microsoft.com>
 <20191120172026.GE3279@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191120172026.GE3279@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-21T00:50:15.9009207Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a364226a-e37e-4eb3-aa43-53a93ad1a097;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:f4fa:7273:7e45:7e9d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d7b3fa6-50a1-456b-0030-08d76e1cc774
x-ms-traffictypediagnostic: PU1P153MB0172:|PU1P153MB0172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB017239496A4A5ED34C7695DBBF4E0@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(54534003)(199004)(189003)(76176011)(52536014)(76116006)(14444005)(256004)(33656002)(74316002)(5660300002)(86362001)(6116002)(14454004)(10090500001)(46003)(6246003)(71190400001)(2906002)(71200400001)(10290500003)(476003)(8936002)(66446008)(64756008)(66556008)(66476007)(8990500004)(9686003)(55016002)(22452003)(25786009)(102836004)(8676002)(107886003)(316002)(11346002)(6506007)(81166006)(6436002)(54906003)(81156014)(446003)(6916009)(99286004)(305945005)(229853002)(478600001)(486006)(7736002)(186003)(7696005)(66946007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GsVLCVbCvZ8TiH2zBdKMERgqfYJph1bSHcv5z0XSxbvifnwlWxSYFavIfKCFUiAMKNIC/gqBT4o62427r336DTzg1T+FiINfrB1jxU4Pf9OccQztU/0JRQWhxEO6boeLY8w/5ffwbKHI1Ptnw0rQjLokNKm+H35Jw4d+eLt86amthZwMwEJat1YjK+Io89BefPlA/AyAikZD94Qn8BNyVdRghiN+2mSBYCaSElvdE4z9UHvVm0uLALYBYPCxnscTw5Rkh8CG5uNTPC3kl0xbNW2iGBFLNGF+uxKgEGLmnkKVKlfFoFoVqUkVrbMH+DZPitw6wDmJsZrPcKRZHF/rrXk4f6TR3+EgYQz5iL0KzBlAKceQ4eW4TTggWYZn9XDXIf41PWVuIzkUlaSyhlFExt8mELF1OkiQn5UeeNEajNmNZvOf65HUj0QzDno8K8u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7b3fa6-50a1-456b-0030-08d76e1cc774
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 00:50:17.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y82gsdLTXfKESYkuKT0qulnY9Rp2ZW58m5fe/MjMUP8RbkqcdB0ZCNLKiqjjmhiXuTEXto83ae2gckyXEaKKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, November 20, 2019 9:20 AM
>=20
> On Tue, Nov 19, 2019 at 11:16:56PM -0800, Dexuan Cui wrote:
> > Implement the suspend/resume callbacks.
> >
> > We must make sure there is no pending work items before we call
> > vmbus_close().
>=20
> Where ? Why ? Imagine a developer reading this log to try to understand
> why you made this change, do you really think this commit log is
> informative in its current form ?
>=20
> I am not asking a book but this is a significant feature please make
> an effort to explain it (I can update the log for you but please
> write one and I shall do it).
>=20
> Lorenzo

Sorry for being sloppy on this patch's changelog! Can you please use the
below? I can also post v3 with the new changelog if that's better.

PCI: hv: Add the support of hibernation

hv_pci_suspend() runs in a process context as a callback in dpm_suspend().
When it starts to run, the channel callback hv_pci_onchannelcallback(),
which runs in a tasklet context, can be still running concurrently and
scheduling new work items onto hbus->wq in hv_pci_devices_present() and
hv_pci_eject_device(), and the work item handlers can access the vmbus
channel, which can be being closed by hv_pci_suspend(), e.g. the work item
handler pci_devices_present_work() -> new_pcichild_device() writes to
the vmbus channel.

To eliminate the race, hv_pci_suspend() disables the channel callback
tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tasklet=
.

This way, when hv_pci_suspend() proceeds, it knows that no new work item
can be scheduled, and then it flushes hbus->wq and safely closes the vmbus
channel.

Thanks,
-- Dexuan
