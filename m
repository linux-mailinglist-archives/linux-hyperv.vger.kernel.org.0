Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42252193052
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 19:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYS2w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 14:28:52 -0400
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:25024
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbgCYS2w (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 14:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSEzZWU1Y+FTMzmJG9MNLuZ6H63NhqU4TSPfy06fagv1As0qn+3lMR7jUVHMO91rKLm3TnFc+FZl+e6ZKJnOf5EmLrB+LuY0QeAYcF7YupSDUFUTtTYC/gBhpthaGnipDVT3ZOw5VsCYdmYi5Tg+0pm3IrR0W7sJ4nj4Advr1eeSaKDz8spqKP6VvTxSCFQzooTcAEgSvozGNT2g1e9ym9QJv0xT1dWXqaH1PezvR9jAG1to1D11yLVpJSj8XGXwm1tn1dAPYnhJWgEWMEI4OcQJxAC8dX8doHMIUpmm0rZ2s0fISAF4MiJEtKJOI5CbnR1jjc6gF3AJybQOQsAMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58W/Lx8q/5ucMLuMq99DvbU2ymj1QXwluZD+FMaIYgY=;
 b=RIH6q0hlIDu5XCnzcTIjrI2ZmsvngXlpWNK6cMrixQbnBzFjsgDTxIst3Rtdk8x609C31y3jZh1POnKxAj2oU53rzucb7TMeQi/El2zJWc7h/eBwNyvInqgyawV9opshgDN+6zoozBKxoHWbDd7/aaxQJkSmqVtt9nmRRL5Mxdbgz+H39ljr5ZyDz1uJXmScrBy4mAjTX/kMoPtylTikBC4CWIWddRSsK4QvSRHnvmpWeDpmfAjAAp8foiPTLkQWxX0Q5dM0aIRn0k8cqYR4VTRJ37R1cXG1WNyD+SY7XZJaZWaaCuN/nZ5XYFH2LPONDuc8zqQ/4nQakwhjuAUBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58W/Lx8q/5ucMLuMq99DvbU2ymj1QXwluZD+FMaIYgY=;
 b=WNIFFlJhPZRGcuk/quLUxoxm5zkdKlAE+VzWGkyjDb4HHAN5FvOAE7WnouosvVLGLar25fjYtJaviGr6WvegC/cRD0hNt8bPqJDNteytu7sRSC9TJCVTq9tknD/C/nwre4DTOMHltOI4sqltOpV7EeuBD8zCWFR+2udUKgwHvCc=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Wed, 25 Mar
 2020 18:28:48 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Wed, 25 Mar 2020
 18:28:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V3 1/6] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Topic: [PATCH V3 1/6] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Index: AQHWAbHhyjbM82h+9EugSPMzjTGeoqhZoqEw
Date:   Wed, 25 Mar 2020 18:28:48 +0000
Message-ID: <MW2PR2101MB10522109A2DB7C0E269B9DB8D7CE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
 <20200324075720.9462-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200324075720.9462-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-25T18:28:46.6316980Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c22f032b-e44e-4c36-916e-36b69aa2eae5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a97bcb6-f257-41a7-d5a0-08d7d0ea5c36
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09381B1127BF79F72F2EC560D7CE0@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(110136005)(66446008)(64756008)(6506007)(8676002)(66946007)(66556008)(66476007)(2906002)(54906003)(478600001)(33656002)(81156014)(81166006)(26005)(8990500004)(10290500003)(186003)(55016002)(71200400001)(7696005)(76116006)(8936002)(5660300002)(86362001)(316002)(4326008)(52536014)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ze+lnrUG8yuyF5T47PGYf4/xFnXdsLklVpVV1kOqEejDuxwpi5sfOzndKAGDvAwRvGIUjY6xXe48Tbk23PYlX4UB+3hAKcC8mSsMR31I+PzLaNdTZXPLg71L6Ti/uiXk62TPq3T8JpvADC7jFoF2MXgqoskaPBSo8iAVtLNNXQc6ZowG2fsxzMY4ZJv5ZDw5Q+tSUz6tG8zAGjY0tbkfD8veQ4Nc4JaRTdf6Lw3nCKYbxxtgbgUj5rGU817RuZVQgR3Xy8/x7+sdiEroyBYFXmD/FRyHG2pRqdVoMwnF/cS4nFh8di/7FD6PmX4A3ddk5gpPmHDy9/AJIeTVnVBfRhryPGLDB5h/QdF4I4p314s2zGdta00zrMt4ZvY4AHhe+TKwFFdhZL2wPgiymmjxjNQCFVQDa8zaJClJsA1gmHE8oqx9bA+A9ISMGvS0vB+a3zr4OKaFamYD5ihEUG0UusFc9kH3387E3XDs90QWQ0zNaE+6Y5DNNPPCcBHKQ+hr
x-ms-exchange-antispam-messagedata: j82Hia3DFxeDpVqeDN/VIioOZacSNZ38WGOPOlypOoG9cBiTNUeghdVaZLsOYUst/NHNdhFWvlBCFW607qDAaXhEwXzShe9iWocuZ3efe2tw2wk21xxX8R9hybk1Cg+TY2oxzcCOEgNLeSJK31guvg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a97bcb6-f257-41a7-d5a0-08d7d0ea5c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:28:48.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZt2K6NmqXoNwbi58qmdhsbNEdjeQ8WUYOX7ztKQPqeh4ZvpKzshhxvfJ7iTkYJvjmeGyemF6ai/Ra2+OE88CY+Yjon1g7nkH1WD+Xj012Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 24, 2020 1=
2:57 AM
>=20
> When kdump is not configured, a Hyper-V VM might still respond to
> network traffic after a kernel panic when kernel parameter panic=3D0.
> The panic CPU goes into an infinite loop with interrupts enabled,
> and the VMbus driver interrupt handler still works because the
> VMbus connection is unloaded only in the kdump path.  The network
> responses make the other end of the connection think the VM is
> still functional even though it has panic'ed, which could affect any
> failover actions that should be taken.
>=20
> Fix this by unloading the VMbus connection during the panic process.
> vmbus_initiate_unload() could then be called twice (e.g., by
> hyperv_panic_event() and hv_crash_handler(), so reset the connection
> state in vmbus_initiate_unload() to ensure the unload is done only
> once.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
> 	- Update change log
> 	- Use xchg() to change vmbus connection status
> Change since v2:
> 	- Update comment of registering panic callback.
> ---
>  drivers/hv/channel_mgmt.c |  3 +++
>  drivers/hv/vmbus_drv.c    | 21 +++++++++++++--------
>  2 files changed, 16 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

