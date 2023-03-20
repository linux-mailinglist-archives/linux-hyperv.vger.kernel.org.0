Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49B6C22EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Mar 2023 21:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCTUiB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-hyperv@lfdr.de>); Mon, 20 Mar 2023 16:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCTUh7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Mar 2023 16:37:59 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9432E62;
        Mon, 20 Mar 2023 13:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci1yra7BwpH9ZvYQjUOilgh3iSR+YZjyBrlmOM6uMnjNoYO59JBN8Ciy7A630x2/7EJ48AmfVXMM8tJc+KjfotpIo+XIzJR2+TgdTXm+RR7je34h2lc3wzdwyrsGjXOXjqf8Ea264cAPK0KhCwmPP+HBi/jRGWEJnTZo8MGU4aUQrkUPoF4Qk8ER5buZx7J6QjjkxXMbAa2OBITN3qLV+39i2TYl4Z3F5QF+A3XqaessBtzG3iBesgwKYmbcaHUAibRD+LqlOu9042hqmFXkpm9p4GItWzG4IElTCZEvyFQL1fM7y2c2T9TGtTCjmIF3kP7WbR9ShIoy8JF5IoFpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJctajBk8y346055HeY57IXVWTkLQpflqV5YhHUDdRY=;
 b=blTkh5cDsng6L2/ytkZxxRpYTmR7bHKvkHKobWYQlKH+5f7cpjcQRW1Cu+JI3qPmIXNKdZ3q/X/6EE+9KzNK3OWnPNH921FMQEkLq4MOWoLg7xjKz8dINwFf+dWnFUjuUzYT9SuKb8Ud2VLu7d7KhHGm7Fr6cZqncAiHXFb5vN9tEg4qYb34Cl1z5K8DfpQPUSsmewwu4Rb3JTrvSlI3kKFTV6mEUQhB6flPtIPRcpjXFK2GbbMvV4WqYrvJq8LxPC8jnSjQ6r58GpFcYlHCC+M2AWw1uDS1G1F8uNwhu7fEcYmoTIVf1DbDFsZKsrp9fL2LSk0DibRkru7zBMguzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MWH0PF12C9271EF.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:3:0:5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.1; Mon, 20 Mar
 2023 20:37:04 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.002; Mon, 20 Mar 2023
 20:37:04 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Topic: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Index: AQHZStvOKEpex/oSu0efNAklHfBImK8EQWnA
Date:   Mon, 20 Mar 2023 20:37:04 +0000
Message-ID: <BYAPR21MB1688FCB69EAF96199D13FB64D7809@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=84770a6a-382f-479a-b480-0005184b3b32;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-20T20:35:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MWH0PF12C9271EF:EE_
x-ms-office365-filtering-correlation-id: f9c04cbf-3324-4c5a-731f-08db2982ddd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QntERTYQTFkBcyIOLbe38ops7pllECYAf+JsDEP5hfAa0yZkwPad4iZdKXm8TLYQwHTvTb+UUlEkMQEz680XLI68ZueBtxtfiPV6v95mntys+JzEs20bnc7dyzf8YDCmiJEzfUWXdeud0bQ6TzCKEHdDecBtdVlRWMMmPHu0hsS0JkdVUqUq7CFU6C9Kz0jgVc5cy4Nh7QExSQ/A2tg3I87JWwq8IyOhj84Tzj7r2gb3jy9iOEzPgsaj2x78oJa4IonC+t3VvqWhh6P3ma7IkZX4rA8RYP5UMyHYOTvC5MVNT4lvp3JfNS5+qjOzvt2hhx3wkHZ9lLcUY8axOWv5yhly8+brWFgz1A4/RyB71SOxYF6d0ThG9I+h3TRCBF3VOGFh7nDZj961XsLjqplM6u1htsuJcaDhRUfhTT/CqcwRhcf5kIrKOxdjVtbUer3hzCJTKzh2w/hPwLu+t6d+urxeXMTuPzw5EEvT4dVKoKeMNX7HZgse+itJSUwA3b2FkFwq7bKAE/+mReqWwz8aUGx+Rg1ygXjt1BHUnirswZUTHzm0jzo+Egn65KiQ9AorZfQXAqFYoGw8a7eA19h9o5xgZl9i+1RfUiKFP8jf3JYJTwo0FtlH0YZHoWrX5+bH6BM8JEQyp/AaoWjFUzjociWaduK9eDY/u7SF9UYy9MiJwTm2Xte4ULQjDEZfT/Ow7xCyPd3NgetKtwksKPTIMCAeVrRp6d59nIHyn4SygJaxTqecB3hjX96uH84r3rxn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(110136005)(316002)(71200400001)(66476007)(76116006)(66446008)(7696005)(66946007)(52536014)(66556008)(86362001)(8936002)(64756008)(5660300002)(6506007)(8676002)(82950400001)(41300700001)(82960400001)(478600001)(10290500003)(33656002)(55016003)(38100700002)(122000001)(38070700005)(2906002)(8990500004)(9686003)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hvDY+3vUtAegiMBQsnkV/+NoKNVLTEGMaABSmLOND8F7JCOEQtwgYbwxZQrZ?=
 =?us-ascii?Q?U3pSRVJemv1emt/UWgTNJGkRtfXAPaJvcRm8mxjmiFxewdMaH99aYa89CnkT?=
 =?us-ascii?Q?gTBUFUYEk2uTrVdB3XZPOb7q9LA2G46bkBOCgzNiDKFTH4X+f7lS1TUV7x10?=
 =?us-ascii?Q?EcC8gnCmk3qzslB89CBYxVT7SdTrQHaJ493KNtSZbEZQkhZVZb8aE88kg15I?=
 =?us-ascii?Q?XPe7aVC4k5XWwYNXoqUZLVFqtX2Jx9QpCihGRgKlYZ3QcWKMHMQuZjKoqtx1?=
 =?us-ascii?Q?3wSo1QUqAfLu+h/urnUAESyOYzh+29jeaNs7EA+mPzc4iYMvuNWXJ1dwmBX4?=
 =?us-ascii?Q?pZjhXVbBZBCknuzveZ1m7DJ3HTuKxJJuoof6b0AI5mOhpGzV9uZa2BlBrfLi?=
 =?us-ascii?Q?bbGdqZwYtKKB0EHzkDXCa4noOjwVqDjQFZU8jcRRoE4UEaAqKYJE5jlXqHnO?=
 =?us-ascii?Q?p1n/gMoaY0ogEqYGQgzRegqyRNhYbfhnSFteQfU0AG+Tp06kC/E2NKEjcl71?=
 =?us-ascii?Q?Eltl8dXk8c3HdbbLScwW1pPjAxmFhh7Ife6wTMZQhc3nKNeHvlBh7W1cGpEH?=
 =?us-ascii?Q?Mj6dhspSD7rK/8nGZ6/TGv80xi+xTTHxo0wbFkNma4cX01L5jbs52cmchzkv?=
 =?us-ascii?Q?icCxQPeYJk3nMK0+Nv0fZw5esaE3yRIWRL6Ddr8mfNIKWz+awiYpj1u3LwoW?=
 =?us-ascii?Q?t/cs5vYgTVALBFkeFL2a3MX7fQlJEvHCDlI3Ujocu5i+g7OWA05wG7buyahp?=
 =?us-ascii?Q?cscfxiPJu9lqz73eYzLsNQUdcAhhCzydlQ39amDEoOuvPTZLjqBdf9vjIKCG?=
 =?us-ascii?Q?q4Iarsf3MHTFQrTU/K/s93l5M24sJLyPiWH7/KHZ3Xm5YxeP0W9nnORSCcj/?=
 =?us-ascii?Q?Ho9Wf8mPo9eqOuIo2T6JA3eehhApdf8VMqGGfG09C8AL5hojQ1y0uShrzyML?=
 =?us-ascii?Q?XDGmKhqxN+FJvSYOyx3ttpNOHF3LtmnGTz4nYUHUKE3XMzmUNhhSPm52NL79?=
 =?us-ascii?Q?rnlmkfrOQXKqOxkzUt9xn73Pnc/I/Z4/ttPq2qEbz8b05e1ZZmRi+WrYhgGG?=
 =?us-ascii?Q?q8pVaEiI8UbATQs76HrIGLNT70PSdYAhZjnGM7w8A38VVgZlB/14uI3XodbU?=
 =?us-ascii?Q?USjeakQ/fYOWdENghaRCYt8Cs08iimkWZ3KuZjK2nPczzI3kx5zY4Gqt8jZP?=
 =?us-ascii?Q?jAjejxgjThcmJBn7YfDKrjX1+JXbSaJoRrypPd1WrcgREdvfiqVRDDhvMHjG?=
 =?us-ascii?Q?Xir85AMRKPyAL4Yq/+zIxW9vHMDS5ed7eqE4Q3jhc1Fk4B8Rw75darLPu/zz?=
 =?us-ascii?Q?owcT0ZSCKqUV/rvlePv6dOQh9pvgkJN4kv24agw0pv9e5TO+kaEWWjmYay0f?=
 =?us-ascii?Q?WPhVsGjjUL2X9fDOLNlpmuudUW9mTw53xl5z+u6e8zotGXg/57rMte1uhvM1?=
 =?us-ascii?Q?ZSiD/vaBmqAgLA+ysT+JEfvaDSN5eEkrlpmm0KDWpNVHOZJJJu3YchyNER+1?=
 =?us-ascii?Q?WXIWOjyelKeMLktwpAcrC1oukhv4r4pYbZvTASbbhgUW0UF4qaEHBV0QaE8g?=
 =?us-ascii?Q?c5n+zSSOpLedbvJ8TPX1tTLG0m5qLzcCB0v+Sc0IRhxsn01/JtrpmIIGCmAV?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c04cbf-3324-4c5a-731f-08db2982ddd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 20:37:04.6399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHuW61mLErfBaGPMPU9+sP0iO2TI2t+8EZXESOip5Qk4FdX0qA1FxJ3wY2CJ4B0MyB6Wd4N+l1+ePSWSE2mlztbyzttMGXICSoPZ1YHV+NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PF12C9271EF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Monday, February 27, 2023 10:46 AM
> 
> Some hypervisor interrupts (such as for Hyper-V VMbus and Hyper-V timers)
> have hardcoded interrupt vectors on x86 and don't have Linux IRQs assigned.
> These interrupts are shown in /proc/interrupts, but are not reported in
> the first field of the "intr" line in /proc/stat because the x86 version
> of arch_irq_stat_cpu() doesn't include them.
> 
> Fix this by adding code to arch_irq_stat_cpu() to include these interrupts,
> similar to existing interrupts that don't have Linux IRQs.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Gentle ping.  Any comments on this patch?  Seems pretty
straightforward to me ....

Michael

> ---
>  arch/x86/kernel/irq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 766ffe3..9f668d2 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
>  #ifdef CONFIG_X86_MCE_THRESHOLD
>  	sum += irq_stats(cpu)->irq_threshold_count;
>  #endif
> +#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
> +	sum += irq_stats(cpu)->irq_hv_callback_count;
> +#endif
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	sum += irq_stats(cpu)->irq_hv_reenlightenment_count;
> +	sum += irq_stats(cpu)->hyperv_stimer0_count;
> +#endif
>  #ifdef CONFIG_X86_MCE
>  	sum += per_cpu(mce_exception_count, cpu);
>  	sum += per_cpu(mce_poll_count, cpu);
> --
> 1.8.3.1

