Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09462E37ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2019 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393925AbfJXQcV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Oct 2019 12:32:21 -0400
Received: from mail-db3eur04hn2012.outbound.protection.outlook.com ([52.101.138.12]:42110
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389313AbfJXQcV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Oct 2019 12:32:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4yMr25Ohn+eGi2D/ngdXQh9Etu989gs7syCKCAnXdzc1Y7wPzAjby21OMS/ZwC8pgQN1pTJp+gxTJ+dEe7SM0j3XYOZlZw/dxfrwVH3boEio2wtIGKJdho8g+kYtkZhEFoCQ4f4MczXmimH/yycpddEAA5Aohp98iDBOfNFPZFPiAvEmCNQA7A+A8jDjdce27cX1Els6einHsDvqLx3c7VdPAnu00z94NHcAdfj+aWq24krU0jTKsM+svuInOQOCksDI7hVtt+MPEn3eznUVyNMmn+EgbG9bxr0cIaTzkP7HfpIMRDebpiTAxaZYS3md+cCP6hpK8Tr4jrxD7FWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fawo5oN1s8a05mGnV6DWzrYYQpaf6Uj7iAa1CYWy5SU=;
 b=EWWgZ8SkdDLuYgetyaWwEK/U/U/FkchTVEi1iV/JBvbPiYN7unRSLK617Bmsk1cFm8stofhhlUC9zn0Hg5wmiK71UycUjX7ne2NmmLLGdvXRjaHY00MokGKiiknqF55CMLeXTabgCUyoFvzAa0zbl6eqwFGgkCgh0r6e9QP+fyRGGnkbKRLTrVV+8EI/5BYyPIQx8sAtu0EBYlt90IGbdaE0qvpQtlKXMFG5mj/SemjU1uyWr2ExCLB30vk3+YtLkBP8H/kaIPEhpr5mrT1nx0CrFgGW+WqAvOfsrZbP5k0viphPgWnEmiYPuZAlRTyNcIkBK8hLwaMM8Lf0XsuLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fawo5oN1s8a05mGnV6DWzrYYQpaf6Uj7iAa1CYWy5SU=;
 b=cEdT/jIQL2Jni67qKnGqowNuBsszi9fHoIBV0a1g28Wx/6zR4EM/mEPO7BODhVddCofLGEJCDNexL7iCTxQDSd1oXCpSNFClfM1ik+4+zhBKMH9DICPvfE4sI/SAJPofRVALGjMeX8wuiS2fEZHpiqAJiOlsB8xEiCLcmqSaO/o=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2305.eurprd08.prod.outlook.com (10.172.218.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 24 Oct 2019 16:32:07 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 16:32:07 +0000
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
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVioF8f6JnvYZ8LUKUUp53PHF9w6dp/CAA
Date:   Thu, 24 Oct 2019 16:32:07 +0000
Message-ID: <20191024163204.GA4673@rkaganb.sw.ru>
References: <20191024152152.25577-1-vkuznets@redhat.com>
In-Reply-To: <20191024152152.25577-1-vkuznets@redhat.com>
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
 <mikelley@microsoft.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P18901CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::30) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a944c21-b0e2-48f0-7f95-08d7589fb5ff
x-ms-traffictypediagnostic: AM4PR0802MB2305:|AM4PR0802MB2305:|AM4PR0802MB2305:
x-microsoft-antispam-prvs: <AM4PR0802MB2305344845E4DD6519CC55E7C96A0@AM4PR0802MB2305.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39840400004)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(229853002)(6486002)(9686003)(305945005)(2906002)(7736002)(76176011)(52116002)(4326008)(6246003)(33656002)(6512007)(1076003)(316002)(6436002)(256004)(14454004)(86362001)(186003)(66556008)(64756008)(66446008)(26005)(81156014)(8676002)(81166006)(8936002)(99286004)(66476007)(478600001)(66946007)(5660300002)(66066001)(54906003)(446003)(6116002)(36756003)(25786009)(58126008)(386003)(6506007)(11346002)(7416002)(6916009)(102836004)(486006)(476003)(71190400001)(71200400001)(3846002)(14444005)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM4PR0802MB2305;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-transport-forked: True
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHYxf4M9FHHHHkEw6B1P5t1K/5JgPzcHciYQa3hxJctZELaJl7UGO6DPK36Fz+NhGYG3lRZ5s0cayj/7AGuxgpNovQ9uX9ebIjgpy3nJS9ABihkvmYKyeBbmxwgKO9Cxg/FvtdK7jGsqEHzgEatqkUgN7/AThHm6TRtMdEJ+xnbavSsM2cPXTt1V5RpKBs5Sv8f1/LTXRFQSv+zLEx9n9M5gFO/12ZBFGFfBUAXRAmyYN6OtdXbKLKCCCAvVGDY6Q6ZsrSIdLVb5SyCyg8IhMzYJsC5j9qkDR2ehWsSuEW4riDoIqx2VNvCBxAkDFCG9ZGXakxW7dNGMlBnuZ7orLaCarRFvOTZGV4YgHRdfhEFG9nxTde+IUqm+YKXWJWGfjFWhTDQ2kY320cQs7s/u/kGG3tge1RaWkDvYc6Oc8RUZM2+hPA9iONEDWBScdC4pxp708ZrZFxwRS2vI6gHFB6zgFdZERMmmG/SunfjTZ55j3AE2o5qravlbaOoh1tq/IlHiKBl2G6wbfjweAawzow==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03073080DC5DAE4AA941C4E9409541E0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a944c21-b0e2-48f0-7f95-08d7589fb5ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 16:32:07.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRg6FX4h/YS9Af2t+BBdUbfhinXHpy+bvFI9uZxOxiO2VrtezmuIgJzZiWEMiYXLsPG6V4uVUTtF3df9TX4X5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2305
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 24, 2019 at 05:21:52PM +0200, Vitaly Kuznetsov wrote:
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

Is it with APICv or emulated apic?

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/hv_apic.c           | 22 +++++++++++++++++++---
>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index e01078e93dd3..847f9d0328fe 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -194,10 +194,26 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
>  
>  static bool __send_ipi_one(int cpu, int vector)
>  {
> -	struct cpumask mask = CPU_MASK_NONE;
> +	int ret;
>  
> -	cpumask_set_cpu(cpu, &mask);
> -	return __send_ipi_mask(&mask, vector);
> +	trace_hyperv_send_ipi_one(cpu, vector);
> +
> +	if (unlikely(!hv_hypercall_pg))
> +		return false;
> +
> +	if (unlikely((vector < HV_IPI_LOW_VECTOR) ||
> +		     (vector > HV_IPI_HIGH_VECTOR)))
> +		return false;

I guess 'ulikely' is unnecessary in these cases.

> +
> +	if (cpu >= 64)
> +		goto do_ex_hypercall;
> +
> +	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
> +				     BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
> +	return ((ret == 0) ? true : false);

D'oh.  Isn't "return ret == 0;" or just "return ret;" good enough?

These tiny nitpicks are no reason to hold the patch though, so

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
