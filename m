Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCEE6F34
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2019 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfJ1Jfr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Oct 2019 05:35:47 -0400
Received: from mail-bgr052101130089.outbound.protection.outlook.com ([52.101.130.89]:46995
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732678AbfJ1Jfq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Oct 2019 05:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVbkzNoyEpldP/I24Dr+EaaYBAAUwXDeRLiMo7DkkbkIoAmcXzC+vEIF24nk2RIHKvHwgLL+adxk4saO0jtUxetYFJGEce7u/zek2MxNodK/hQQBeOf8bPe/9zgYGMBp7vZ8TfwkWsvpF8hLd+KS9IHNkukEoElyAWCd6A3MhbkQbwhOVQ66QxBV3xfOUUOu8GwBbQ9w28QxadZpdfkaYkidNcmDpjjMr1v0F/506CXVO2sbnom3znusH4WnDYoh21FIS29qVHIem2ln/hBz7XG0zPv/WZv78pgQJKeb0fcp8MPXycuouYvf48vgsBrUySH0IXsNHUwCO88eHp+1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mZ2pbAiNkn29N79VMvYN8z+gNxLUsGCv4WxtPLhRho=;
 b=YJ74TeNYrzWFuWyMRh3fs7hVIswsUgGgk7wzJ5jSFpv6XYXjnUzfegkEpy/dofCGVFSEoiGrlYbrgzOofrcr+6OhAg5utXB80vs2vHVsghCnPv6ey0ou2mQYZKUXWhp9oA3OTd8DCin15jRfXOLqf1TVCwVvrIosNQCNsd0WM4e8e3tGqrWcqeJWSOOYQcPr7AIU0ydQK0Q9dLEN74mw7lzOCr0uOY2N9EiElQQ1h7am/0nIVEqARwUBCgMQI2SysmjYaJWOVzFBWA7pELE2s21U+azOmhsD/kbgPP1R7CLHzHxjF/GW/Ip9WvvZCMJ0YL6g6LlShBCzdZt/b3ugWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mZ2pbAiNkn29N79VMvYN8z+gNxLUsGCv4WxtPLhRho=;
 b=a4LHDuf80w7da4LpD64fuYG8pf12kksHpkGfsTXZm4RQFzdr59J3lL7BSwpQfT+PRMAWD/GvkB7ZnAXHjHVQ2dgzjaQ7mxiaNIuLtrOABrqcLoxiaV8LTi9yDHrxDkA1yDL5R5fmXOI4d7TKSbjCTsbT0NbUqx3nvI5j70Ar0CE=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2276.eurprd08.prod.outlook.com (10.172.218.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Mon, 28 Oct 2019 09:35:43 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 09:35:43 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVjNn473X+0wGhnUOCRzZ/uvX6C6dvzGgA
Date:   Mon, 28 Oct 2019 09:35:42 +0000
Message-ID: <20191028093538.GA9711@rkaganb.sw.ru>
References: <20191027151938.7296-1-vkuznets@redhat.com>
In-Reply-To: <20191027151938.7296-1-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,   Vitaly Kuznetsov
 <vkuznets@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,  x86@kernel.org, "K. Y. Srinivasan"
 <kys@microsoft.com>,   Haiyang Zhang <haiyangz@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>,    Sasha Levin <sashal@kernel.org>,        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,       Michael Kelley
 <mikelley@microsoft.com>,      Joe Perches <joe@perches.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 395f6612-ea38-494f-386c-08d75b8a33ac
x-ms-traffictypediagnostic: AM4PR0802MB2276:
x-microsoft-antispam-prvs: <AM4PR0802MB22768A009B1890C9661B3641C9660@AM4PR0802MB2276.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39840400004)(199004)(189003)(71190400001)(71200400001)(186003)(26005)(11346002)(6506007)(446003)(486006)(25786009)(476003)(102836004)(478600001)(33656002)(386003)(81166006)(66066001)(5660300002)(1076003)(4744005)(66946007)(66446008)(64756008)(66556008)(14454004)(52116002)(66476007)(76176011)(99286004)(6116002)(36756003)(4326008)(8936002)(86362001)(3846002)(6916009)(54906003)(58126008)(316002)(7416002)(7736002)(14444005)(256004)(6512007)(6246003)(9686003)(305945005)(8676002)(6436002)(6486002)(81156014)(2906002)(229853002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM4PR0802MB2276;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-transport-forked: True
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+BlratBuPpvYCO8uSJWZ1dVMNt78bi0UsXWPOGrINwAJ0vaTOY/9DqmgM+5NB65wOr0zJEU173jPpT3B7DONevbOdLFPT4hVHN+vpvCjAvQrn2gzj5w7NEjNvJcEzsCT8r5UpVR41a1Z7xp2HwQpV1ajA/o0IfmP4+3MeKLqsZzlhI6NDT2xTkzxZqWATQf2IlSstCSEzu0ndCXNU7Dt4wgUQOfhnIlyykV5vIiOkW7ULe8koycgadfXmIYIQOBryxAFf0/fLddSpn/GL0fxR9Z3dwe3HLdRHrZLSYRniQzvDW/vGHn8DQC7O7fDxpA+GO3fMSdN0IcuI1+Mn/Wi4nK44EdMXSA7yhcl/4diK8pfe0wFn7I8XgOkVPwgWan
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89B8387013B49445A75278895B07D0C5@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395f6612-ea38-494f-386c-08d75b8a33ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 09:35:42.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M2mNKIsBakrUX6Y4kq5ksbs2Mbn7CpQKJo6W/hlzqu/Axs3EbdHHhnuKKvVujinkYKoXHJiHQKQfuuKLVwmnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2276
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Oct 27, 2019 at 04:19:38PM +0100, Vitaly Kuznetsov wrote:
> When sending an IPI to a single CPU there is no need to deal with cpumasks.
> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> cycles) improvement with smp_call_function_single() loop benchmark. The
> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> important for PV spinlock kick.
> 
> I was also wondering if it would make sense to switch to using regular
> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> vector)).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2:
>  - Check VP number instead of CPU number against >= 64 [Michael]
>  - Check for VP_INVAL
> ---
>  arch/x86/hyperv/hv_apic.c           | 16 +++++++++++++---
>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
