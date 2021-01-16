Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B705B2F8FC6
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 Jan 2021 23:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAPWsz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 16 Jan 2021 17:48:55 -0500
Received: from mail-bn8nam11on2120.outbound.protection.outlook.com ([40.107.236.120]:37601
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbhAPWsy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 16 Jan 2021 17:48:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxYGHf4aXxFl6LT5Ke3nbpCO604QDXg+yp2oNlZdYVEQ7Df5fxbuse23cAZBjzyVuHomWBPgErewIkUeB/JIbm2KT15JgDvrve5gE9h8oruGi5CQ/g0TYfmqOkzJn0XeX1+M1FHHTrHWsKHJUp/1rcL2L6xgrkEbSEzQ67MO8nLYfneiKxRe08AGA4GSTdg6jzvin8bogNnCuoobUggE7j63Pebec0wMwc8YCwgl/m1/k3X863Q1iCnVHU3urA9C6jayzKAQM/fojPlhW9wq8YEHjdm4EKbIsT2bSbAR1gvCDbUHX+bnOGnhH+pdmr4J2uMmQD55fZVERtswfWYN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vk1Fp3clsS7/l/W7hV6X+ufmXXw2rmhj7sRTEffXWw=;
 b=FXTPaDL5zI/fbRogtdOgbQTQ+I4mTmVzlxDuzC9oqgDuan9A1P5LLJeuHEp7Y3ILvpfV8Pp02hk50jYH4UrUDEv4tP0n5tA8ChpSVRl9Gtizr66d3GYEnJfmLvvqVK93NL2OUJJFLJp8AMjO8MLl3B8ysimkQs8HHkZ2R0BfkGi/Y7iBZ47CiQZoBC1RT92WfJYq/KOSpWLGbOCEaIouuQltX/riVJnazYixTOzUtbHdRlhhf2ZI9IrJzw1kGRA8wieeGa9gaoNXzvR3citH7TM40RowEe/tXrsbILizKmG2FnoiPWCu6T+oLZNff26muEYhNAkQoFrShqj2ollM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vk1Fp3clsS7/l/W7hV6X+ufmXXw2rmhj7sRTEffXWw=;
 b=GNzx2WwZycfmJr5KO0BZ+XVntKZ6+jNHByJbJI2VcTiY76M4Gq1+5uLIDawlYgnwMuDZTBypilRslI0WYFLkcRVBlw8dMUcB/Gtz81lOUYxljo0FHmeLMHqA517y/zNYJnal2fN3Nc121mv654EI9PqzuB42fNcJ2PULizFe0Hs=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0286.namprd21.prod.outlook.com (2603:10b6:300:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.1; Sat, 16 Jan 2021 22:48:04 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::dc63:8d1f:5969:95]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::dc63:8d1f:5969:95%6]) with mapi id 15.20.3784.008; Sat, 16 Jan 2021
 22:48:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "ohering@suse.com" <ohering@suse.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] x86/hyperv: Initialize clockevents after LAPIC is
 initialized
Thread-Topic: [PATCH] x86/hyperv: Initialize clockevents after LAPIC is
 initialized
Thread-Index: AQHW7FduWJLsjQO6Hkac/kxkBh4746oq2lEA
Date:   Sat, 16 Jan 2021 22:48:04 +0000
Message-ID: <MWHPR21MB15930BECFDF0251D36CFBB98D7A69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210116223136.13892-1-decui@microsoft.com>
In-Reply-To: <20210116223136.13892-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-16T22:48:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d5bdfcf-2b49-4029-8f10-5eb2940a13ac;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d16f92f4-7153-4830-fc4f-08d8ba70c92c
x-ms-traffictypediagnostic: MWHPR21MB0286:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0286246FC22192725BDF05FFD7A69@MWHPR21MB0286.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uodhQKg0qVXGyrANK9YwF63/V/SVPjUukyaEhWxOR5M3YudB2+IvzR+n0O0uS8ySiTofZFQNJo5SCvOBa3dfmHTpZbUBT4KpLHVzpaWfcPvDoOvU+t90gnoRbt2hPpdJvJiKb3GqwbIdHQ6ydIl87UCduBfJhb33yFm2ybcUqko3jitsHwzbH4IdIi19B2KVON1Jth2et0/CF5HZdqRrs9LieeiJGyhtGKf4qoiraOx5eFnvWo5Ui3rYi+GN+OvnnkwORHSO0kAmKzS7aQ72cIvjIipn/e61/CDwy+syl9CdPpRmq4lK0oZsT5SjxubmA8WRnUHwDCm2jQPjPzfCq6UVm5An1eUZoLJOFBKDY2z84aGdM47CR62a0HuK4ch8fIwA9u+Jm8yHitsOt+ALVhmHEaFWQBVsFteHsRL99jSO5sCREWwQRk3uZjfBbQg1qUDh7YBak5JBHC5adgYHSDJczzcBJ3IJluEgyqHXK7JMK1n10cW92BwitDyOrBBC9dOI0wt8tbyTwW52n7ZW0UbkTpTsQfYIPiRkIvcD7oGuxBRuQVdEQkyDnyfbSs25
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8990500004)(83380400001)(52536014)(9686003)(2906002)(55016002)(316002)(71200400001)(54906003)(478600001)(26005)(33656002)(110136005)(5660300002)(921005)(186003)(64756008)(66476007)(66556008)(76116006)(66946007)(8676002)(7416002)(8936002)(66446008)(82950400001)(82960400001)(86362001)(10290500003)(4326008)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bFZKHw94+ZhJEeXpu3nbQwjf1YQ8aRQtSclOdgilnT6E2gfTqmLE57pyHOou?=
 =?us-ascii?Q?MoXw+3NCBeS5LfqYyvCkp7HDwTnIivUDJ8yk3EalJ+1/yfkuNPgPhu/wvQGP?=
 =?us-ascii?Q?oIcYR9IvpQevi+dLt4gClhZesQm6NJFRYzu6DqpOSISRjP7/3ImaNrMyINGS?=
 =?us-ascii?Q?ExvbHG0a1vT7ygHrdN2g+Ps08fQopCUMcBytHBXEn/hB8PZ+jSA9Z3tzc9JF?=
 =?us-ascii?Q?E8VeF5qpRHyi76e/7OrbqXL8gykDreMRenwahP3o/UvPLv/Vz5qpfp1vuTG3?=
 =?us-ascii?Q?5AqgSRy7U4GkcOjOXjKVrs8Tg/m/zGIptTO7/bzBXqbsBaa9tHfnvW0VPvay?=
 =?us-ascii?Q?c3MD8RpHUgSg+0HH1I8JvCduI27p67v3csN+1EzXaZHZEPLtLgJuBvpgI51n?=
 =?us-ascii?Q?5SMxQuQrxWkGnYcQ71JtfM/ky0mNJ7L2CkOXlvpt9yeeIZ2l5iN+8W9NoD39?=
 =?us-ascii?Q?O20ifbsxJ2JU2iP7FUaUYaMhVfOoWp9HgnrxOAC6Wdr51kY4G7eSvsqbSy2E?=
 =?us-ascii?Q?VlMXg03Kit7EmW19rM0HTjUMrmn5iYWcwkAy5nRSoG3kKYmLMobQyLFxv0zd?=
 =?us-ascii?Q?5hREQhFvsGv3syNxV3RiiZMbhpLRWmyluv67OWlZEYbQfdMqgwJBOl+30t5p?=
 =?us-ascii?Q?AiDS7ukrCxQLs6uW+o5/ag2IKVFYx1hfemw1s7CF+ZfDG+IC9D9YCWi8YYbv?=
 =?us-ascii?Q?C7YFGHAS21vepm6spJo3pMwzz40ELCuoXa6VzDEmVbaab8tEjdgYH0yVvUIa?=
 =?us-ascii?Q?yzf/EPg0Vwcmyyu6iow7G0WHVInhSQ9P+J7gesiVrECFNYJ5LIvHVggT87xl?=
 =?us-ascii?Q?9kNea3+Pa9GUjBZhJcjLTHdMjhb7rfsLJO4n7fvuMAuWIvk680s1CDpINlcU?=
 =?us-ascii?Q?gdz1CKIVJrZ4ZqlL4r8GCkKe6baHP8kN/Pk3JmccCAMwV0G/Q9XSXDPLVG+B?=
 =?us-ascii?Q?ARXAydcMdFOrfJ0BuaL2AMAI5dYxZM+acSFcwKbgHqhxq4W8rGygZ2aNknRK?=
 =?us-ascii?Q?Ah8uVvljWx28cKUFY7Vbv7DjmF/H+BhXQ6J4YpSCzGADJpN23i6pI5bC1RJf?=
 =?us-ascii?Q?mk3lVZs0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f92f4-7153-4830-fc4f-08d8ba70c92c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2021 22:48:04.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99Kkvu044Ca0nkIm+LMy2HAIRpkwp2vevIwE3kqzGdZXNHdq2CSWY/4mrdsZP/6PsBL0MaOQh5nSs0MickuwW4tENkQKDyOffQfbuU4OtTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 16, 2021 2:3=
2 PM
>=20
> With commit 4df4cb9e99f8, the Hyper-V direct-mode STIMER is actually
> initialized before LAPIC is initialized: see
>=20
>   apic_intr_mode_init()
>=20
>     x86_platform.apic_post_init()
>       hyperv_init()
>         hv_stimer_alloc()
>=20
>     apic_bsp_setup()
>       setup_local_APIC()
>=20
> setup_local_APIC() temporarily disables LAPIC, initializes it and
> re-eanble it.  The direct-mode STIMER depends on LAPIC, and when it's
> registered, it can be programmed immediately and the timer can fire
> very soon:
>=20
>   hv_stimer_init
>     clockevents_config_and_register
>       clockevents_register_device
>         tick_check_new_device
>           tick_setup_device
>             tick_setup_periodic(), tick_setup_oneshot()
>               clockevents_program_event
>=20
> When the timer fires in the hypervisor, if the LAPIC is in the
> disabled state, new versions of Hyper-V ignore the event and don't inject
> the timer interrupt into the VM, and hence the VM hangs when it boots.
>=20
> Note: when the VM starts/reboots, the LAPIC is pre-enabled by the
> firmware, so the window of LAPIC being temporarily disabled is pretty
> small, and the issue can only happen once out of 100~200 reboots for
> a 40-vCPU VM on one dev host, and on another host the issue doesn't
> reproduce after 2000 reboots.
>=20
> The issue is more noticeable for kdump/kexec, because the LAPIC is
> disabled by the first kernel, and stays disabled until the kdump/kexec
> kernel enables it. This is especially an issue to a Generation-2 VM
> (for which Hyper-V doesn't emulate the PIT timer) when CONFIG_HZ=3D1000
> (rather than CONFIG_HZ=3D250) is used.
>=20
> Fix the issue by moving hv_stimer_alloc() to a later place where the
> LAPIC timer is initialized.
>=20
> Fixes: 4df4cb9e99f8 ("x86/hyperv: Initialize clockevents earlier in CPU o=
nlining")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

