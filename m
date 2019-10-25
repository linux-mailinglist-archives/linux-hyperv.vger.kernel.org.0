Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCAE4E37
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2019 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395307AbfJYOFq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Oct 2019 10:05:46 -0400
Received: from mail-bgr052101128031.outbound.protection.outlook.com ([52.101.128.31]:43597
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391167AbfJYOFp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Oct 2019 10:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKSmbkvHFBTaJ2LP68E+948gn0YXjwxehlBbLpOJi2f9rWBF4mUmyaWRkKhiX6SlRskKB1TTPiZWYcLOZxJMAdFkDZwuMcK/haP2MvpzoazNC9GgIzT2qWrtxp8WMlmGUflZSkJcve6aJ/p64snwpNZ9NgQsKXwFjpQnRHB9CPuKA5pMoe2ub/YJ7jIAXNmuXCrrX4ADJVlQVkHz/vbVGqSBvswQ+x7bdHJZX1C3iwKaMOOoZSz4fhttsLOSCfqOxOOWVY9AhcMhAs8wJmCuyaXb/gE2VFDl6k+ZCospQDJjOagHXHm3BJe0UzVk1VIqfTN/vuRuhrXrxwLWD6Tx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O/r+LuFaXM2GSlpXuXYCqLV/rv/L1195FjopVoNzMc=;
 b=DTX0zIhQKvzddaV7SYjr8IMBOIWfXTnLhRETV3DwLK/xJvd3s8pYK9YQS+0z0scAU4Vk8ePCFCC65BqCqLqazg9ByLIP7g7NWgG6FE6LlgGDD1YD1x0XKY6k6Yu4YX1pgb4HRNR4tKNb8W7o07xKmKKoSbxqhAoC9YhwCpa9IMcm4Xbr1Uaq1IpW3ZtyqMTYqxAFahvcmZlC4enFJO8nz8PgbMWYS13op+lp31FCxjzWYIH+pUoC2C5Fjt/oQZADEGoNUm27dhDdMcyRkmZggSP/xWsl+PfjHNIX4WTPXwrn6jOoUkdgxFFMsrxAw9c5xAGZKeSTpzEoay4VilLxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O/r+LuFaXM2GSlpXuXYCqLV/rv/L1195FjopVoNzMc=;
 b=sIMUaT4RjjIgBcxgSJU8tSyvPvP1IC0tgik9h6NiaVj6R7flGAsCAgsh7TkUZ8+bp7PQTRvd88HExB8eJRvHgBS8j1N4mdEwIn1tNxPjccCKvsX6bpfpLgyieCW09wrW8jd3nAPgCiBWLeF0Nam2caZY0ZYUff4DHRws+9lvQOI=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2305.eurprd08.prod.outlook.com (10.172.218.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 25 Oct 2019 14:05:34 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 14:05:34 +0000
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
Subject: Re: [PATCH v2] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH v2] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVizZYGDIi3UW4YkWmU3NiXuLPeqdrZBUA
Date:   Fri, 25 Oct 2019 14:05:34 +0000
Message-ID: <20191025140528.GB23240@rkaganb.sw.ru>
References: <20191025131546.18794-1-vkuznets@redhat.com>
In-Reply-To: <20191025131546.18794-1-vkuznets@redhat.com>
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
x-clientproxiedby: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c7f713f-f0ae-4066-f730-08d759546743
x-ms-traffictypediagnostic: AM4PR0802MB2305:|AM4PR0802MB2305:|AM4PR0802MB2305:
x-microsoft-antispam-prvs: <AM4PR0802MB2305ACB8F527740BFBA40C8FC9650@AM4PR0802MB2305.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39840400004)(189003)(199004)(25786009)(6436002)(6486002)(52116002)(6512007)(9686003)(186003)(26005)(476003)(6916009)(102836004)(11346002)(446003)(386003)(6506007)(229853002)(486006)(66946007)(478600001)(66446008)(64756008)(66556008)(66476007)(14444005)(81166006)(8676002)(81156014)(8936002)(76176011)(256004)(305945005)(7736002)(7416002)(99286004)(58126008)(316002)(71200400001)(71190400001)(6116002)(86362001)(66066001)(3846002)(2906002)(33656002)(5660300002)(4326008)(1076003)(4744005)(6246003)(14454004)(54906003)(36756003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM4PR0802MB2305;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-transport-forked: True
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8pd8kFQkHqtKZKOvPSqIYz4JlrN0v97YFj/WKQVwk5y2PCvgvkzXVkFG4WwPcbO79f1Lu2SiECdPuadYhSEo33GyTLy/pjn5F0mAYjw+fnu9rQFlG3rzQ2dz5WN8TEVRAqrUlaDA7uMHnJ7tpJx0uCVMYc+3RAD0xrWVEs8Pz4ygmX7vn+GnEdNkHiyJB+flE5j1DtWZq364U4Mf65NKNx/D2pHVooKaf1BXRu8phI5tUB4mwVGSlearY90A8VrOoHVGGN7vfl7xwuwedSRWf7iwEZIBh410YIUt8bEaZM2k3ceb/YrCk4ahGFCbmOkEHpvawMynCsR4MgxVxb5/mHr5Yp83IOeAHFFfXHWdL3JLS2lFbMB5k4Yih2seVqybn6tFXnuZhEFNOs7G7yCWO2ucmRK79rRXQmjgFPB8g7JLYmsJjPBVxKQdHUgrctptQ3EDDiwsmLzPffoRfanCC/2z4aOv1rZdGgPfuCFRIMazCmU1Bhop25CdCNCz7XrA8y9OBCBcytvcED7ES6mKwg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7910855E4302C34FB54E12C5C8111618@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7f713f-f0ae-4066-f730-08d759546743
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 14:05:34.3785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFCAnhKManmWYXAW1ARwqbi7ni1EVTlvJ+JfDcDjTBmCvyohSSEIYZZ0APM0rm7dSOVHEuCRpX1jq1kT5kULHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2305
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 25, 2019 at 03:15:46PM +0200, Vitaly Kuznetsov wrote:
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
> Changes since v1:
>  - Style changes [Roman, Joe]
> ---
>  arch/x86/hyperv/hv_apic.c           | 13 ++++++++++---
>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
