Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB11A8D48
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2019 21:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfIDQnT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Sep 2019 12:43:19 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:19353
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731904AbfIDQnT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 12:43:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RckszFnA8OBHVYKwyCwtU5mmLAhVdBXimo5Uq4BfTfpwhZGKw84R9i4gwUPBqiulQgzkRyQAsGK3iGpK8ATH1BSzbTtWyoicP90AZ2zDyMQcGWXr8PPZjnyvP4nsKx0gRvPYbLu+Qm8CDABFwH6cA3l7HQ/9308tzdXm0k3dicmt50QOZk82dFw7IyNbkWlUnjBPp6FT0EOo9iTH5bbQCeM3fRNnMlu+Qz3WRX1AA982YtU7zoAd4KuQ/9dZxwpv53h6ZmAbyBbnDAvZ7RYHPvNrepTLjYKzDFjWveAOlShgH8W/vdVk+XmfrxEJ6VTfzaeDLYqqqkTCXlwSuUdedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ly3J+pBk2qP9IXiwRthAQWrECQUCKES/BkOiaubCl0=;
 b=SqHXLzuGtSODxVwVYVW6oU+4kLBreeHJHBkgV65X4y79UCZC2HXK2hAt1ZZZa+YHt4bQZukiMMMSa+KbgDANmGNHf6zi6vZb4xE4M+4kBHJeJnRhVFk1EfTEyv+POYUOo04Vo+G5SucW3gwgGyZdiYqHHN8Bj/hyhssEytaeIHm+wxexpN58WTn/X8d5acS5x3CQNI0Qw/VzuoNZGLONDi1rp2r4jZNDGg2GtdePiHyUOwDgdFPuPwDD8m0wn9mTzc/74Z70JmKKYGhvaHEB10oFi7qugHvq69Z6oH9Yw9020lgZT+JeaDcjY9msBTNHlHq92bzXLL+nr0k5yd1n8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ly3J+pBk2qP9IXiwRthAQWrECQUCKES/BkOiaubCl0=;
 b=SSfy7ZaSTpvYLPXX4LGI/LFO28m2t9FNdj4tVoXrFPNOYhuSMH3gafSb5FgYYDFyuK4kJaSZm867F8837rg7ABRjATSAD2emi0CTmCjxbKHXXCNzNLPqWKkU9rtLKWec+ZTGaQuthkOglwVSw2JQ2dbXLn0nWocFAwWfl7N94NQ=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0794.namprd21.prod.outlook.com (10.175.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Wed, 4 Sep 2019 16:43:15 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Wed, 4 Sep 2019
 16:43:15 +0000
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
Subject: RE: [PATCH v4 02/12] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Topic: [PATCH v4 02/12] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Index: AQHVYe3JrHu+0vx33Ua7p5urdffONKcbu4lw
Date:   Wed, 4 Sep 2019 16:43:15 +0000
Message-ID: <DM5PR21MB013752686F0911F0254E8E5AD7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-3-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-04T16:43:13.8295179Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e65f02c-2ddd-4f84-a66b-e2077f2d8611;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:c9a6:edf8:bca3:c905]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cfe4d8b-ede2-43ef-a947-08d73156fbc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0794;
x-ms-traffictypediagnostic: DM5PR21MB0794:|DM5PR21MB0794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0794D46E60DDAFA2748E474AD7B80@DM5PR21MB0794.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(10090500001)(6506007)(2906002)(33656002)(1511001)(66446008)(64756008)(66556008)(66476007)(66946007)(186003)(7696005)(76116006)(76176011)(102836004)(110136005)(22452003)(316002)(86362001)(81156014)(6116002)(478600001)(81166006)(5660300002)(2501003)(2201001)(8936002)(10290500003)(8676002)(14454004)(14444005)(256004)(71190400001)(71200400001)(52536014)(486006)(25786009)(476003)(6246003)(53936002)(4326008)(46003)(11346002)(229853002)(446003)(8990500004)(74316002)(55016002)(7736002)(9686003)(305945005)(99286004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0794;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7YeO/fGHiFW1838SMYQdPVajH2YjkOg/XbqnBISX9IYt7p8p7/8aX05LcilPFSbig7XHb85L1DnBa8P6nB+DPqdqyALUKbaVpyojjKL6Ath94h1B7kKhIVehjti0pw+GMLkNthxfH1buv6QveYDo4rxTc5L8O4jTDxnyCJNcwNo4KO0qKUg5HWmfuBkmrjIqMLsumgqpO4EZ3fvfO0eFZMVh981UtQapPK20P2pUNSVqP3MOPgr3GplxRfebrpSkwp9BuFp6VeOSyqiCg664FGz+eVx1ezvUex4JRgwi3JdbeGw5A7HorcqYhjPKCI3JgyFQY/OT6jgPTfXoVhtOHIg41B4OBtVuivAwEadr71QNMB31pHld5guKjeKt9VTHjqW+WIBrq1H5GOA7y23X6RZvXDz9K0S93UosFKBcfGc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfe4d8b-ede2-43ef-a947-08d73156fbc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 16:43:15.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR14dce4hOLli7o1D/muRaanExthXk7/RZuTdosMVFHj8O+WWZmrFB7HRPvgFs0DsxGwmFEzKLr8W+FswOJ7CJnjyMhkxZRVwa5Lf8BakhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0794
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, September 2, 2019 5:23=
 PM
>=20
> The API will be used by the hv_balloon and hv_vmbus drivers.
>=20
> Balloon up/down and hot-add of memory must not be active if the user
> wants the Linux VM to support hibernation, because they are incompatible
> with hibernation according to Hyper-V team, e.g. upon suspend the
> balloon VSP doesn't save any info about the ballooned-out pages (if any);
> so, after Linux resumes, Linux balloon VSC expects that the VSP will
> return the pages if Linux is under memory pressure, but the VSP will
> never do that, since the VSP thinks it never stole the pages from the VM.
>=20
> So, if the user wants Linux VM to support hibernation, Linux must forbid
> balloon up/down and hot-add, and the only functionality of the balloon VS=
C
> driver is reporting the VM's memory pressure to the host.
>=20
> Ideally, when Linux detects that the user wants it to support hibernation=
,
> the balloon VSC should tell the VSP that it does not support ballooning
> and hot-add. However, the current version of the VSP requires the VSC
> should support these capabilities, otherwise the capability negotiation
> fails and the VSC can not load at all, so with the later changes to the
> VSC driver, Linux VM still reports to the VSP that the VSC supports these
> capabilities, but the VSC ignores the VSP's requests of balloon up/down
> and hot add, and reports an error to the VSP, when applicable. BTW, in
> the future the balloon VSP driver will allow the VSC to not support the
> capabilities of balloon up/down and hot add.
>=20
> The ACPI S4 state is not a must for hibernation to work, because Linux is
> able to hibernate as long as the system can shut down. However in practic=
e
> we decide to artificially use the presence of the virtual ACPI S4 state a=
s
> an indicator of the user's intent of using hibernation, because Linux VM
> must find a way to know if the user wants to use the hibernation feature
> or not.
>=20
> By default, Hyper-V does not enable the virtual ACPI S4 state; on recent
> Hyper-V hosts (e.g. RS5, 19H1), the administrator is able to enable the
> state for a VM by WMI commands.
>=20
> Once all the vmbus and VSC patches for the hibernation feature are
> accepted, an extra patch will be submitted to forbid hibernation if the
> virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
> false.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 7 +++++++
>  include/asm-generic/mshyperv.h | 2 ++
>  2 files changed, 9 insertions(+)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
