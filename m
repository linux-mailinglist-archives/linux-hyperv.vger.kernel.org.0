Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055424BA64E
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Feb 2022 17:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiBQQoe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Feb 2022 11:44:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBQQod (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Feb 2022 11:44:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA13AC;
        Thu, 17 Feb 2022 08:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shkuyn7kcK5W9A3nkw3EXMPapBPYN3Samqsmj4nhgbbeZh9JWmnQ5cDYP1FU3FolyHusfs75X03O7HIOWbBhpmyB9zmTtNZfusJoyEz6XHeZ1TeIlFUKo0LHsFmkveUyPoy1YuiHlkH6vV5LVdXRtmv7ZrmPnCxw9j9uGWreUmojH1kqCpdrk5zItQ3/M9UE6bIhglsKUNuu9oZC0yKsrjcPgaB5welR6nH2SxeuB0mAKI0OwbQveLcrfXh77wr8uPwj+Xuyyn8LhrOKLHxH1B/qQnuFCQT0Y1KsiS+rXHfjajpUMqjjJM1OZzbJR5GAdW1q/KpH5hhYZm2cGQAFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pv9uIdekkIMb8S85Kxm2R0YqYVcKW25TQ4CkWw4X/E=;
 b=Ji5rl6m6iavSmeu7j0ZCJqczN6/Fv+Z0KlRvbfqnCFH+BiHiPDJtYDlLk4iO7DWdRZEv0OpKlNPOXw0SlAJXu1y3XKZAkuAJqFneO2+/UUuFgWqkqBiZwio9puHvfP6N3UyKhdgpR+vXuY0bdVPP/dCVMBiirY4zkIFdsuVU1/WH/slsUN0HkS1qnD3dy0/TS9ZW/y5TdXwz2TmD4NfJ8d0cHZjjcBsEtHCzMfIP4UGkBPp57+onrwzYz6TRbslszbnvvPanAy1ijD6UOt/SU9cw2JRKUAyov4AEcOj22F5Y31PndEpxotf+DzqWSaFPQ+5mghWXQyiiDcUI22DWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pv9uIdekkIMb8S85Kxm2R0YqYVcKW25TQ4CkWw4X/E=;
 b=c6wNdMUKZO5uonFsnbmAKY7Fo2Tz6H2fagjdHOmprq6YhTVJ3GgYbnLxpJIi+KyU9bEsc9jwAf4zRad588zHj0M/ev1hvFRhz1u/csEoLWinm82XW3PergBM77W/jEBnUkZ4yjqDelJ5o1yhzhgoW0DBXFmm989ZKw1HlEwPPk0=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CY4PR21MB1587.namprd21.prod.outlook.com (2603:10b6:910:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.10; Thu, 17 Feb
 2022 16:44:13 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::ad12:1420:5435:34e4]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::ad12:1420:5435:34e4%5]) with mapi id 15.20.5017.009; Thu, 17 Feb 2022
 16:44:13 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: hv: log when enabling crash_kexec_post_notifiers
Thread-Topic: [PATCH] drivers: hv: log when enabling
 crash_kexec_post_notifiers
Thread-Index: AQHYIgympyDoJIn0jEOJRMc1uX9nZayX9IWw
Date:   Thu, 17 Feb 2022 16:44:13 +0000
Message-ID: <MWHPR21MB1593EAD0167AA9EC4139042AD7369@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220215013735.358327-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20220215013735.358327-1-stephen.s.brennan@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ffdb1fd-c82a-4029-8393-d58b4452847a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-17T16:35:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 488fb92a-0e63-402c-a000-08d9f234bae1
x-ms-traffictypediagnostic: CY4PR21MB1587:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR21MB1587C6FA7264B2ECA0DF2D22D7369@CY4PR21MB1587.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrnyBaJ9b+1XsQC0uBnaD/I4fWE1YTyqf8RpJMgU3bUvEPxTUYks9Ii5rAZW0YkzaVXigjExlH8Q/3x8QVU2FN/h2S2SJ2GEpDF2oHwzH1os7zzLCvU7niG4+WlCx2OSNiYSpJH4ux0esj2mw/8I/poOfFskz5aHhG9I1+Kuj/K7Tivp9keTo8CHlur9BdnnW1AGtUXLaMM7uctn0vIX6ULgEA2BevD3Zb3dCDKUTb0AKOXbFhT+ffTIFsoyTrjTR2U9vr4vWFLNrdTO1lSb7+UK86UNW/X8jwViEoHsBuUvCzaY4z1XgvR0dKT9EA3jE7wBX8OXK2wUBl+o16GsoS9qcDAVlLul6IB+waXkE2qQhT6+15XZsqrkRQdm6+WnlGb8Ie65E5zNHcLKdo5WsXAtoAmcSir+PiQLZJAJmTqBE1xy9lzFJvkq/LRpD26m5Iy5zMBzNabi0qEIYVCRtmn8i96SW//ndd1csZdmVxSh3OfEUBZunKBl5mikipIDvSmwuBuJlge9xUvK/PWRmxphjSBKdrNWezIgUaPeCSOn99pk8wq9tIS5/RFpO0AYzi3RRU8XtQI78B35XJeerNdccQ3fStcYwhH0Q2tvVXcMmLDyJrLiPel2Zew5Dt3FB+mURMElEX2NVmM8pqhsQZvdq/MsqQo+3Ic6W3+gqoMbpOAEU1NQ7dKg4mjlOkYWoHdKf/t6tu39CGZZJaOK00rZ7LFR31hZPA9X+KBsuTjRb7ScLJxldI+8Q07V8eL50fteYWbWA6/NWQoj1+KGsOpCIrI7AkHx7WdUdDgLtWENpESi6PFAOAmPiaIh1yBkDHObMw8acCWNvl1VhTy8dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(2906002)(8990500004)(82950400001)(82960400001)(86362001)(316002)(33656002)(6636002)(38100700002)(83380400001)(10290500003)(55016003)(508600001)(71200400001)(8676002)(66446008)(66946007)(76116006)(66476007)(66556008)(64756008)(38070700005)(6506007)(9686003)(186003)(966005)(4326008)(8936002)(26005)(52536014)(122000001)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZBNhj8TrQ+qr/5bbzGBs5Enps1gcRdiTAu57y9rwgLKliSXcmfO7HK5FmpWz?=
 =?us-ascii?Q?/cv0ere38a4wM92kIxkw1e2T4l3FSVTq/YcM4VGjRxEhXmateYHW56FD+MF4?=
 =?us-ascii?Q?eni+3HfSMevLzZfnTJ5kylB28+kVFRi6GpGtL0Dse5bst1nmmuPg17C/EXOt?=
 =?us-ascii?Q?sRDDHgCVGEx//EVigN22k/kyW0ujKMStsBmkVO2RbZ+iTm8LUPl4eu1pedkW?=
 =?us-ascii?Q?envUpa10pBY5ohTqLmVP4Lo2dHC4VIzRxgUsOhRlL89q4HlCsDMekYUjpMbT?=
 =?us-ascii?Q?TKgJZc4AGpnFYacmRmWlyHBUWvChVWx1ly0vEbi0V25Mtr3DTP736OO1BpQ8?=
 =?us-ascii?Q?I8rAvRIGAeFzJwTCy9visuTqnOHjePiI6mQ79kOycK7ladEE+7sED0SEuiTZ?=
 =?us-ascii?Q?Kttk6vBP3YfmyBxlX6CQBMsIA822UN2cbBxc0iPwtt7Fu93CvfEp9q6YrgoZ?=
 =?us-ascii?Q?7p/d44y122pCJXIegnawiF741lkEEBhVtmpIglV8n97iks6poLx/FfzaeQvt?=
 =?us-ascii?Q?Xk7l1un9Wflk1v7njYrdxX25+utopKWEm1+UU+5FnEi06hf7nBGsaBFep1Uy?=
 =?us-ascii?Q?CUO+cjPfZXQPSr8ejr9YsH0pImKBqaZ0yZqJ5+hpFbYs7jPd5HPis4mfh5nR?=
 =?us-ascii?Q?6OoZLWH1VGR7TH5tUgiQMRgnF8xUjZSNxhisxzcjLYrXUY8G4+bqE2KWZC9T?=
 =?us-ascii?Q?TK97EYdk0KzKIXRBFC5g63OZyOJGi8L6OBfBf3x4yz5EqCtihBFy+vQcEmWJ?=
 =?us-ascii?Q?PX+ip5gfZPcUHOqkDo4+mQ2iH/2kTVOQOGfiyZOdpfaT0MtTKV2dpsrtVMic?=
 =?us-ascii?Q?eCDloPLALEflqpG/c8PxTZunZ9cFTMNbX4l9zhK0XabqgfxTWMMOM4Km7axb?=
 =?us-ascii?Q?mxi7BXRqVTa2qrS/NjuE+xESMt4ISHiW2KdZCZ3H0IAzGppF53ru0i5dC7Wc?=
 =?us-ascii?Q?RX68jM8Iiy7EWCMbTSC1vBzsVHcaK1EJVc7X11mIGOcoRiq8Ie2EAXFF0cV+?=
 =?us-ascii?Q?ZBe6NpB2rXRMBvSgXNr41fVq47lmZoyVmFFLSsRUJ/1Bdtef0UaXLXeMVjwj?=
 =?us-ascii?Q?VkZMmyXAgjalRsArXk3V3R0KYWvLuSttmmG1Rod2/8LZnXaveAKgHhR6VmQi?=
 =?us-ascii?Q?YkafN2bI4CPIgJYqx9eNN9dTwBhNk5KVSsFJVPaUZPm7o7OHJB58j2VTybu0?=
 =?us-ascii?Q?X8OXcoUMv0fEjtKMM3KMEvejpHgQ4MW/aYa/KEdkqsHygziG5Sz6FGbp/mr6?=
 =?us-ascii?Q?FKHXvp1yBYunJ+g847F9FqpEAFNH1Bp7vtXx/fiQOcLobxenPTOue4s0fwo0?=
 =?us-ascii?Q?ofL3sqdWzSgHqtD3nTjUrjrS4jmBRpA+wWMfCO9XjRZqEf3l54Z3GSqGcukv?=
 =?us-ascii?Q?28F0qDS6ULKjxPHC6/2RcUNJ35ea44FhAwVsIgAG0qTt4qZb6/mpYvPR7b8Y?=
 =?us-ascii?Q?/GACBVYndSjbGwNGXEdXy2DbMXAGlVwHyWFabbM4Lzyc7EkMbliyWeo0wqIq?=
 =?us-ascii?Q?7Vkm+0G5C/ITWv6ieIrCpYtkPLlFhs9G9NZRDR8GpcRxTM3vv9NOHmkjCfkK?=
 =?us-ascii?Q?D/Vh4kLslf1jBRdR6wI8DmayhWEpudCl31iuln8T2JU+jTItL/qZ/KAgV+UK?=
 =?us-ascii?Q?SI5OSV7gDP6vkOu6nBaPDqlJvwgZXujW4JAx3gD2MCPKd3e15BHuQIZxHuHq?=
 =?us-ascii?Q?dPdw6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488fb92a-0e63-402c-a000-08d9f234bae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 16:44:13.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Uu40z/aGFWj7AhCS2waPZ6GSQIIN7TXwGLuTnkv5YrKw+pFZly9Xp3uIdAT7WnqhW023xxFANeENoP7xRGn0A+CIgGzq8OflGPN/TzbX64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB1587
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stephen Brennan <stephen.s.brennan@oracle.com> Sent: Monday, February=
 14, 2022 5:38 PM
>=20
> Recently I went down a rabbit hole looking at a race condition in
> panic() on a Hyper-V guest. I assumed, since it was missing from the
> command line, that crash_kexec_post_notifiers was disabled. Only after
> a rather long reproduction and analysis process did I learn that Hyper-V
> actually enables this setting unconditionally.
>=20
> Users and debuggers alike would like to know when these things happen. I
> think it would be good to print a message to the kernel log when this
> happens, so that a grep for "crash_kexec_post_notifiers" shows relevant
> results.

I'm OK with adding this output line.  However, you have probably
seen the two other LKML threads [1] and [2] about reorganizing the
panic notifiers to clearly distinguish between notifiers that always run
vs. those controlled by "crash_kexec_post_notifiers".  If the changes
proposed in those threads are submitted and accepted, it is likely that
the kernel log message in this patch would become unnecessary.
But since we don't know when those proposed changes might come
to fruition, adding the message for now makes sense.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

[1] https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli@igalia.co=
m/
[2] https://lore.kernel.org/lkml/20220114183046.428796-1-gpiccoli@igalia.co=
m/

>=20
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  drivers/hv/hv_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 181d16bbf49d..c1dd21d0d7ef 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -79,8 +79,10 @@ int __init hv_common_init(void)
>  	 * calling crash enlightment interface before running kdump
>  	 * kernel.
>  	 */
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		crash_kexec_post_notifiers =3D true;
> +		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
> +	}
>=20
>  	/*
>  	 * Allocate the per-CPU state for the hypercall input arg.
> --
> 2.30.2

