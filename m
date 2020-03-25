Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAF193071
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 19:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCYSdd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 14:33:33 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com ([40.107.93.102]:20172
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbgCYSdd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 14:33:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVJFth7ZRfiHNgPD8swkczhQAnSXfeBzR/Kr25pLmcNGicb88BHaH6btK1UEYhMp3Oz1iS5qy+e/fgh/kcqNuhm2T8VfPuLNDIQqUKxlj24N4X6LHYkm9Y7iJzdcbwAFBaJAk9eH9q3KZKzvd6Ke/T4NcyE2FPAG1X4BMtqruMR2v9TWDzDM8du2HZmpMql10mdJdmLJur7/1mOnkEb8o1sQyni8W3uE3esQFG2tJ3pfEYjaxyCPuQsQA/HE977v4uWz/r3vS6qaZbi3tYO96250uicrNA/hk4ZnRmWALemClakoEzBf6duoQsJYLNLTxy6E4KHp2DBDgdBerNTeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSYhwwXXng2R60IRot8dXYl9nwnqc++s+bjgausg2Zs=;
 b=bVwYGazs0dL/5m1moOQSbwtttwSGR/nu2klCMBJG4CAMsUPtPCZR8G8GrkwMEPYGceRVuI+ldPficJDGmW75Bg90bed7YMUpLscFCiRyHE7prRDAg8AwEtvlPqVHOAMHCNsLAPtgy01Zy6+pnWfZuRsvlkNJc1l6XEE71XJpEOrwfFKCXi8UdnTrP/LWJxy+i9IUyCQK+QKkyh7jdV4EU1p6kvz/l0RzVeL0+ry0FIwv04tcG67+uNpQ0AGXFUn0G1BHxzT28y76LpQCKJiN73+MiBasZoKSE/76Br/3opqYpTBx/S9UhpaDnv21hLwFCAp5gknUPrd1VPcYfEZOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSYhwwXXng2R60IRot8dXYl9nwnqc++s+bjgausg2Zs=;
 b=Mexr2fxqzMFJKhC0sWUCWNvg1q0SJQ6J0Y04NpCxVWtz5pHoq7nBTsSPbhXjn1bzFX0ex4sjNiauIXcm38t3nh8/n01lvx+crk1IFXWumZDAFJA3r1BFOrMvQBb95xQJz43VYmmObJgDy1Oa5qVW2azAV7i51awUgBlO6mWqFBM=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1098.namprd21.prod.outlook.com (2603:10b6:302:a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.3; Wed, 25 Mar
 2020 18:33:27 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Wed, 25 Mar 2020
 18:33:26 +0000
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
Subject: RE: [PATCH V3 4/6] x86/Hyper-V: Report crash register data or ksmg
 before running crash kernel
Thread-Topic: [PATCH V3 4/6] x86/Hyper-V: Report crash register data or ksmg
 before running crash kernel
Thread-Index: AQHWAbHkWZSdft85wU2lQwThbXev46hZo9qg
Date:   Wed, 25 Mar 2020 18:33:26 +0000
Message-ID: <MW2PR2101MB1052302CA7C500F727DF6C92D7CE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
 <20200324075720.9462-5-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200324075720.9462-5-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-25T18:33:23.9537715Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=912a60ef-0a00-42df-83c9-f8ca4627d007;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 294f24cb-53a5-4980-9071-08d7d0eb0233
x-ms-traffictypediagnostic: MW2PR2101MB1098:|MW2PR2101MB1098:|MW2PR2101MB1098:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10983100BE0E73E16CDA973BD7CE0@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:279;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(66446008)(54906003)(110136005)(4326008)(8990500004)(5660300002)(10290500003)(71200400001)(186003)(4744005)(26005)(52536014)(316002)(8936002)(478600001)(2906002)(81166006)(7696005)(76116006)(66476007)(6506007)(81156014)(64756008)(55016002)(9686003)(86362001)(66556008)(8676002)(66946007)(33656002)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQhSBWwHaptP07UUEdK+TBGR5Vk1tyXT/MqPKgr+b6b/2TYG7o2aNaePu2+56feOUFaobLSx9naL3J/tC68TxBVoYHyTJlzlzRuyQfbE9bkJW0JgALPoqVIkz3X16IKkjJcLZsjn0wN9LApZYFgQVgNzZTtp5vZ92b9HtXFHoEZ+YCm7hHs8NhNBY6sjddd3Q6wXFD4w34RFwdoGRdrNWyf4Wd1xZ8FeP+J9Q1Xgs+llVk2VN2Z3FXVlzu+G+iJlHDiElNDBfHTsnnxabHSoxaPuq+jgFh2Kbq15CK6JWTW2+/W/Yu6WE91/X5kGCrxL19EzHdEPyw/0Y6KDc2mmzJIbv37W4Lq2iAHQK68TuA4WDJ+eCSLWtEM4dMw39wk0xRwYi3FUnL/z3+Q3cusk37mzBYv3X5pETEmV6aCW/bOoZSysaj/LW1vAvrK7f3YaDbmdHv1rE/ffLROeTH60mpg6C5Za1fiuyy2w+NKnwJ0bYJV7KV71NWnnp0PlOfX8
x-ms-exchange-antispam-messagedata: p/tWn47LUhGbmkbfqkj092wd1Winf4T9CYt2132zLUeZAPFd0+W7c8WQbm+tOPDKt9TcuBAu+fM9ICCrWsQM11ulMVu4BIlquWxGHR6QRd0GerVT2NcTOsdwa0uCcrGIXPFJMHXKiDTQYMFwsEk5+A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294f24cb-53a5-4980-9071-08d7d0eb0233
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:33:26.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yGea54uFC25Pw2mfeRhWmR8BfezNcqihedD520KIKofVckf/fEPKhriAKMw8oRVcss0DFe03rExJrZiaOJmUqADE0hF7JDIy2DbzeVh8hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 24, 2020 1=
2:57 AM
>=20
> We want to notify Hyper-V when a Linux guest VM crash occurs, so
> there is a record of the crash even when kdump is enabled.   But
> crash_kexec_post_notifiers defaults to "false", so the kdump kernel
> runs before the notifiers and Hyper-V never gets notified.  Fix this by
> always setting crash_kexec_post_notifiers to be true for Hyper-V VMs.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>        Update commit log
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
