Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7ED34682A
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 19:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhCWSyU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 14:54:20 -0400
Received: from mail-dm6nam10on2120.outbound.protection.outlook.com ([40.107.93.120]:4838
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232117AbhCWSxy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 14:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdYCt9522gz1XvplVTbB2XXuQo8FwKJJxNBc+sOMaQfnR1uuRVVu9xcFBu+HNtRlguuLZ5CUD9AKUZ/eprFesfEbh+0ThM8VG3gEZZC4a9T+JtSHGvM4uTdZooCIMwR900PouPRmu4v6cfdeXNxjquwSFcO9DejXNm3XgR8kbSYv/Xyuzwi1VxpIutsWbaGjhINAbTY/KDPbTQWKl/86buTie93QKqJvTtScZXZT+CDkdCZklnLsXwXsNBdQrsFLNXrGosWmOSMGYdZW25evoMG8ECoLVqcgw2Epl7P/Fdtrt/32ohAdF5Sgo8fp1tSS+HM/CZmDknSmEDGmjgjHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL3Plz/6z/Fk4Q7LcCPtQDweYrtDxmzLnFt7S4TU+fQ=;
 b=DBQJE3nAdUHF1XbI6r4eY0XcUcQWnzeIa3ETcf3QdgHOUAPHKgYaIZInz2nrGbAGlf9BDn4rNeI8+mJYVHS9MPb4ALiZ7ftyxEEOi8Q0CQWDmhakuQK4aczWh0IM/PuE6rqBqzpiPJ/hGUXPuF4GaNjMlfAGCA1jWmf4+uZkQZk4L/wVQx0/MUEe6A37MmlAwhW6u4b7HiBzN4hQ9U/Khh73/uECDB1ABOzKmzgiumlATzbKOp150SXZv5bvlCk61pLOXE+vuufkN4kItPlxhgffi59Kh5oQ9FoaAg4WVMYd2aFSnP42lhg6tGJ7dgE+5MGDFQ/eb4FPB4vbV71Jxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL3Plz/6z/Fk4Q7LcCPtQDweYrtDxmzLnFt7S4TU+fQ=;
 b=Qjs/9ioYLgz8Il14WmwOtQCiqQCshl6Cu8g3ECoc0+ns5Yr3oS78lruJwXob2Jrf2WxjivYjJ/3G+4UjZqqvGwK5Wzw2pIuwqq4wrW2E8uNiKv36M3KwLexrVGKWcMMXWeGPFdlqdumoNf9qByLPNAw3kF9TSB4nQvxQxzt8Pzc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0288.namprd21.prod.outlook.com (2603:10b6:300:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 18:53:48 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3999.004; Tue, 23 Mar 2021
 18:53:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>
Subject: RE: [PATCH v5] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v5] x86/Hyper-V: Support for free page reporting
Thread-Index: AdcgFH7dfC3BJtekQZWwJ3zQkLf0mgAAUCRg
Date:   Tue, 23 Mar 2021 18:53:47 +0000
Message-ID: <MWHPR21MB1593992852105271128FF8C6D7649@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f46cd5b4-52b4-4b2e-36a8-08d8ee2cfe1f
x-ms-traffictypediagnostic: MWHPR21MB0288:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0288569B068EE2EB410EFE52D7649@MWHPR21MB0288.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sG3k8dy75xl9J/AlYUXWhGVNRwY40AJ9SCJL1CnMxfctX1BPK4oeEj3j0If/nifqNbeKNB6dwkga01BU59UrpiaYApVgncJ9MW3cjtG+9X5x0ZtA9kcCLylkeVsOPKnkUqeYcRghRKPpJZJjccq0bc8Dp9jBOfEKkuI1dQNl8HLFMmQWeHl2G5d75nT53LynkE7VOZFATi3EWg5ZdiD8I6daJMPHs5yXRVIoQSlLqTFYMOyoBaUGy9baLJsvjZFIWK8z+78xX+GnPEFjgN0TbM00Cxy+6BGzSzU+lE6FZa+dBhQNsnlyPI5LfKrmNQyU/0IJGR/kYEl6zJhFY5Mc5QWd0vPXSbMiDdQfH6rCe1QaI27fmdCl/IML5Mhnn7kspRuSbwFY1AFCG/PoYb6oqt1X2ybpvBMGAgkvMhElq/KQl5r94AR4Kg5ac6LIw5hv93TPmK/vREvxnBp2ZcxWo5tovHlvhLG6DYYQfWahnyTYfZ10+qDro6y+lzi3pB/DPoszDpsV/4RkBviO5xDou0ObWd98vy9t6Tr3kKnXYFN15SpRjw1DhW2B7tCz+R41phdg+cZU62FVDEOXDP3j8ihCiFBdFflqFIyFBKijR5fCjGF4kBx8XelaLWiV2cXZuPR4UL0z3GIc7bzT9Pn7eRammhbRn42s/W8LZBSXWw7J518NXrU7JGLS47yc3fsy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(4326008)(6506007)(10290500003)(8936002)(82960400001)(54906003)(478600001)(316002)(8990500004)(26005)(7696005)(66446008)(8676002)(110136005)(66556008)(64756008)(82950400001)(5660300002)(186003)(66476007)(52536014)(76116006)(66946007)(9686003)(55016002)(2906002)(71200400001)(86362001)(33656002)(38100700001)(83380400001)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9gjNzUHBF8xbamtxTGDjzRWYL5w0mzcy/7Pw8GehUhGzt8cZzTkmjGhe4Q/+?=
 =?us-ascii?Q?wwDxsZm1YMO/7FtC3usb2LiZTbn8DrBhHeV989K4Uxr5GkKvDYiqmLsMdJIm?=
 =?us-ascii?Q?xn9DPZZ16zWescWZq/AqTkrU/6Qhdo8bXNKNsAOf4Hi5WJJ1OagDuS5/EGac?=
 =?us-ascii?Q?ZCdZ1IU3rzN17asd93M5g5P7gPKn+9IvyYesdzWsLni1NKVESMkueB/VXyR+?=
 =?us-ascii?Q?CRmLAFZNGzjKdpNneHOjAz9AT8j1ZzJ7qJMtZxhVvqvWW8xCiHFu3F/Nrs2b?=
 =?us-ascii?Q?ul0xdj4Dz9H0lMo+xWzyjehMljIA+fDKqZ0LaHfCM9A58ZkyuPNyu8Nq6LxO?=
 =?us-ascii?Q?lVnAzl4B9/pFcA0qbaTBjV/TylNcwRuJfRxvteo4gnsadaWq6960hAEjS1ZO?=
 =?us-ascii?Q?IHEoJxFOokKyHLeK6bxN50KXJlJbKNOnReaWH2/J2zuxCV51nF34qf+1LNDA?=
 =?us-ascii?Q?IjCHq8n5GKGURd1p0P2tbSLc0IdyAw5vHFqA2UV0Svpe2E+4JNeJgrMmuVvb?=
 =?us-ascii?Q?g8Zat0dj/SQqUk7PL5dD/DF8gJxUGK4ufqciwXBWX8t6IbpuLtlV8gL47auI?=
 =?us-ascii?Q?yiiKrHiPPl701fT+DSsOx82F4GGmkV0VWOYyNvoQIjarjPqA+Cs8l6yttNt0?=
 =?us-ascii?Q?YbBLhsvcfbsBmkU4TmmUBdTAsFZ5R8p8arockPel3Ef4SVJ5lLrtRYHcNdvH?=
 =?us-ascii?Q?EHXKRL/tGp2ntLckXdkgSQWJa8UpOwI1Vm8zBPKRRl0PG0GX0OAjT9+NnL65?=
 =?us-ascii?Q?L1lBvAlwrUpjEIAL3vCEsKio1BkTHRKyYU55DR+SeQjBs65e0Codve7aeRLq?=
 =?us-ascii?Q?OFJQ64H9wRYRERMUjvLiwg3q4usIfNwDH/dwFBVpAT+xXIvwpnMccJfaqOnP?=
 =?us-ascii?Q?doMwZztxIMsv4JBi8Xu/qODAAMrrggyti/o7rtkRs716mvsbs8zSkIH3QxzY?=
 =?us-ascii?Q?pZP+Ig7B9Qx7sMMkyaZjjcnsmFvWcXeDpuYlqgpNgHkF9glZHipi7ftWrwQO?=
 =?us-ascii?Q?o8NpiraPpXX8b4l6LSTCimvg9Xo4u6jTKyZyVo6HLPL9EIpwanDKAZX/68DY?=
 =?us-ascii?Q?N1+lXdJgn7cix4o1qiC+gZHUQsUfbt6nyGwFVo11aDOYsGagCn9gXSMI8Tys?=
 =?us-ascii?Q?Hhd/XKfKM4+NupaSAuOTdBnrXfeiTEfU4/pzZPe3SbKtqffGIRoZWs/f3UpC?=
 =?us-ascii?Q?ytcKKzCqY2wugjtIYpjoDMMrJaWgJa3UtlxEWkkmghPpN7uCsoDPRX9sL+AR?=
 =?us-ascii?Q?qYnkysArUhzYuy3Sz0oM8+Yu6t1yGdcR5sob2mTA7ZhTcfbXEYhvymmd+M8a?=
 =?us-ascii?Q?f7llDtPJxzAwyJB0m3ueygRf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46cd5b4-52b4-4b2e-36a8-08d8ee2cfe1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 18:53:48.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBd4j3POF3AWwUrylcwY2FpHVByYp7nku6VRxKLwl9/ipRTN0D+28tMcrvxQaK4aiOPCosivANv3A3B4V9UfF8mqtO1Aa6i/ucF5I5I/4es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0288
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Tuesday, March 23, 20=
21 11:47 AM
>=20
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Tested-by: Matheus Castello <matheus@castello.eng.br>
> ---
> In V2:
> - Addressed feedback comments
> - Added page reporting config option tied to hyper-v balloon config
>=20
> In V3:
> - Addressed feedback from Vitaly
>=20
> In V4:
> - Queried and cached the Hyper-V extended capability for the lifetime
>   of the VM
> - Addressed feedback from Michael Kelley.
>=20
> In v5:
> - Added a comment clarifying handling of failed query extended
>   capability hypercall to address Michael's feedback.
> ---
>  arch/x86/hyperv/hv_init.c         | 51 +++++++++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c    |  9 ++--
>  drivers/hv/Kconfig                |  1 +
>  drivers/hv/hv_balloon.c           | 89 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 35 +++++++++++-
>  include/asm-generic/mshyperv.h    |  3 +-
>  6 files changed, 180 insertions(+), 8 deletions(-)
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
