Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165F954B6CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jun 2022 18:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbiFNQvV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Jun 2022 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351712AbiFNQu4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Jun 2022 12:50:56 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B746C92;
        Tue, 14 Jun 2022 09:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqCYXFf/hnTA4+H0VOGHqMvpZZpheuFqLfa1ewYPM1OeUbzmJDj826Y6o+NOfvrtdL0ZD/sWL/9ijp6jM/2StBJhLT9b1CxBhKtA4pWzdVtNUYlM6rUhLORbOzafUBF/Nvn3npBcxO/UwYwlaCe1g1qzE5UcS+67afTU3V0AiryD0xZtanEmIICcPFpoyAiXu+YEraY38+SRc7cFW0N7WF2todH1m412zmRUsC3/nITGEZly/kDzpFha1/7DSHfkAPvU4lx/ycWp8rLpnVtIBlEt5u6X9aYe/qDQMRXLGtVmufD2EMJ5YaC/qlVQeq4l9nFd7xofqwD2Q0V6yMnazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1NSyS0KUs2aUlbgLG7ocZ9VKIzpPua0FM3TPOGG7EQ=;
 b=gUadPvsQwEOY82NDb8o5VBoq1fzag1PsO0VpFY8M0AyQYkxd3Aa8h5KYY1fO++X8rR3zrfGXIW4hcOLnSK+RuFOpmAqeOZEJX+/MftZUN70BCkzTF2XoOcfunuBDY6XUlhYjHN3N9HNbMWbogtbK/FoRapd4fVtd+587xbOTB2oKqB7a+0NaEGoaBW/gDd/eY5H7W0MHjusGNgLIHa8EA7HEcsIkQRUJAmOq17hThvBVxGXkOWMVIzyC2tfGjbxoxlDhIAfprWf372OryzRWDmGGvr8s4CxkhHWg3bKlYGqFHiwrKEh/pcF3R5MkkmfeZaCtrflI8AgUfwl3db4ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1NSyS0KUs2aUlbgLG7ocZ9VKIzpPua0FM3TPOGG7EQ=;
 b=iKUDGAev2aqZcPms3wGkTGL49Mtv3dU2wv+E57aLZ57JpgO8ILjrg2htnIOdLHSw2Za+oEZtHIFNXUdZB2MZE57k14CiuesaaAD9fwOlvz8cnZiyWIgJBN3ti3y2EYuh6FKPeGCbh4ZdLIEhuxIBRhl7pD6aW5/WzMFMpZvxFB4=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM4PR21MB3298.namprd21.prod.outlook.com (2603:10b6:8:6a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Tue, 14 Jun
 2022 16:50:37 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Tue, 14 Jun 2022
 16:50:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Subject: RE: [PATCH V3] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Thread-Topic: [PATCH V3] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Thread-Index: AQHYf5CH8tOKBRsb5kiQ/vyI1iB3eK1PHkxA
Date:   Tue, 14 Jun 2022 16:50:36 +0000
Message-ID: <PH0PR21MB30252886961F6D7EA7B7EBE6D7AA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220614014553.1915929-1-ltykernel@gmail.com>
In-Reply-To: <20220614014553.1915929-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee2a3344-75ad-47cb-bf11-9dd9db407fef;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-14T16:49:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 146e157c-239f-447c-4cbc-08da4e2601b3
x-ms-traffictypediagnostic: DM4PR21MB3298:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM4PR21MB329844E563B1EC8899F9A6B9D7AA9@DM4PR21MB3298.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znvVNEkHoTybgQDvyW0eJOwaHSb7mY5HogpZNzYfCVNxuxAuOT1sOb9LCldr9TWEi5M5KM914u1rSWpmrQntx8YI3pLNLlapnPvCnRKuzGhq7ckP9S3cD8Xsb/HNC8zU9cltUJM+a5ywTbSlthO76VH4h7Y8teICio3MIfaC9VT25Psgnu6kQaYD5iW0TMUnFsZsNeRtU1lb9QeawMQBUn7P67woRbA61sM8siycq03kauqvDXmxm0l+Ta4W6co9wMRfpG9OnazYJiGID7AoerGLkUxIdH3argZpKXHyqLJjou6IeX4yNi7QX7nOYqQLJGlZnQCFYk5R3oED2cQ6HB6pzYLGAmernpyg6ldv7jOwrqA1Z0MWFIkNLaWDZ/ZF5384VwPe0T3FizF+IUfuvC1v+lHVaBZyOMWaH0WkdQkGW3Ybu2UUfz3DF7/W5zWXAN9PEc6XTV2HODp22BIafnwvc8L/xnY7DBaQ1lAUl8V+51TNGcnphpixuCbqMInwzAqPC96Ve3PIJg/1u5Qtk8kOA3vSrYrhqFaRHWlD/pJJMo/vQcB/I77PD3A37k4i4hhipIlq90aH7e3QDTfPwzL+NouqzYVSJBRgWIgXUyP+JSmvlC9evAw5Fupr2NGyeNd26yRBxe9x57v9F5HGqXgHUjeekL3fT4zcsG6YIUv3RIAWJ1FdER+aGx5TOAJ5qo5ZwWueMKiRAntWk+SAVSPbig7I7rv8dLVHq8kQEqVEOoyAVh8If6V8QGXTe/dCxokCAcuvsd+UesPcWD+VXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(33656002)(38100700002)(186003)(4326008)(64756008)(66446008)(316002)(66946007)(8676002)(66476007)(508600001)(83380400001)(110136005)(82960400001)(52536014)(6506007)(10290500003)(55016003)(38070700005)(2906002)(7416002)(7696005)(921005)(82950400001)(122000001)(8990500004)(26005)(5660300002)(66556008)(54906003)(76116006)(71200400001)(9686003)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gldF7G6DwKVNgrwCsJe79YaYVCoQcYBoSsOAQPdJmrHo+S7zvgq2LB6jjJrv?=
 =?us-ascii?Q?MooeVG5ddmTBxxI+NusET+F4rrS+dBsMZdlnpB3WB7ZiAOHJxGhujwS3tcvc?=
 =?us-ascii?Q?6hjPxt07kjTRATmIS2eRUGrFQW2peVJCexjiDNrzFNEOPG5ycprsrXDBbWT6?=
 =?us-ascii?Q?eUebcYiQilr7CU+IyWcwMJECFO43Sqw2pmRFDNfq7AkjGLNHnJfQv8P4F0JN?=
 =?us-ascii?Q?87TqcaGLLqy2Mk291zVxNI7rmKlY5Onej8CicleoDwPOL2VToXoHaEM5Q7mw?=
 =?us-ascii?Q?mHI5K2+7td8kJ8CzCjvowXFcmtXCLRbk+vBqsBz9S9dLAs1gzv9/OopWF93X?=
 =?us-ascii?Q?G5MQ8TfH/lyuiHlVbeHjJvNhef1GW1a0q1EmEjjU1Q2TPALItn+X1mZ48Fk5?=
 =?us-ascii?Q?Iya8B8eNCimTM4kAgVsHRt0Tor9JolMu7h18anCpvCMgc98UL6/eKVnIhps4?=
 =?us-ascii?Q?TL3obJsKkZRCbpfriylGgcz6BjfFrJxzwg/qTPsOJV++nasTgcTRR4Occ9xd?=
 =?us-ascii?Q?ABnA2aURRkb1qkeZ4QTy29Xx/YIrx5UK4gI4wSe6bzFN8lGrTw6U29NsuiCW?=
 =?us-ascii?Q?WyhTZQllayConq6PfMlMzKQSVUnv3Un9TDlPHJSgF4zp2pfORq95MNLA9l5j?=
 =?us-ascii?Q?ePiRwO6KP0Hg7D7AtqDT7wsag26mM252CAtdoMNSOXbpPR2SmicFh3vKySOe?=
 =?us-ascii?Q?zkO1HKXlruz7IV2wrv8xLOi8koxpUZAgidmCo4ofzMxDWifY135oClRFMkN3?=
 =?us-ascii?Q?eq6gwHkRaUtUH90YacqtU3efwFNB8rsgTxTHMF/wD4qSSeHbrtgHRHfWQYCY?=
 =?us-ascii?Q?LqzSUsU9ytwsilQa9Vm+vrpekapoZ4YYtG9w+foT1iqlWK/hUEBWXW7lalHZ?=
 =?us-ascii?Q?VR9ktIUiCLD+GXO7yNslWAOeGoPfdgPW4L2kiC4iSpdabBheOrtYLnbXP9VD?=
 =?us-ascii?Q?7S7q29YKKM8WfT87UwGLu0ZX0r5ubO8ti6lUuIpq/6yoaMTu5e1U5fx3Okgd?=
 =?us-ascii?Q?lFks/X6Jvxp/7Ku3xpP/jNVqDHnDppo/0jhPy0PYbhMmKxLY/aPxbXboM0bQ?=
 =?us-ascii?Q?j676xDx44EwSivwGNZbejlcJlGKsDwB+GesLd/jT/x5Kfp9EExd708q18ThG?=
 =?us-ascii?Q?+4s9k9SWHvF7naZR5sEgB8BNS9R5GTcUxjSUfOBN0LSvY/j09QQ4HkZbvNFI?=
 =?us-ascii?Q?MQQMNCFOGv8exqPSHz+oLIYER8x/P5wyGjjZrSgTYtK2YPXst87ZQezMG0ER?=
 =?us-ascii?Q?3/IiGEPBx2CIk5n8fjR/paIqjFG5/NclDvd5raJaFX/g+r3E0q5ndpzLqb86?=
 =?us-ascii?Q?dVL4WLb7KU1gHSBGrWXyq/GI8FyyfNUNXKVvmrx8SXse/dd91l3n2jhfdfUm?=
 =?us-ascii?Q?r5g5lzq1F/duevIx+wyaSaEH/d1AksmAuGUj4SkZUc7aVxiUNfm0p5+HYuoO?=
 =?us-ascii?Q?zQ1NbkPx+/ZL2L3CLJurkR/eL/a1d+i0QCgdFnBttkAA1Z33GkUvcJPamo5W?=
 =?us-ascii?Q?f18mLk/8Z7egFYulFOr2rgG65LhwH2M8C1npaIgsAvUP6wTmdD0oFmBAJuwQ?=
 =?us-ascii?Q?8rhseaOJmpsvtq1RZJXlbpGWsTyxV5+KvddipiyDzZllSvkcCPMIIlwXrdy2?=
 =?us-ascii?Q?+ymAG0kV7TnLJpdrTuV9AMLuw0VaXSslJEtnSchAhHYH62EGIAI3m+MtPNWI?=
 =?us-ascii?Q?SP7wWWiBlLd9cgPaRl8qFC/MRbwpPutzygLEEXuji4kcuVna7qz9zTkQ3RVE?=
 =?us-ascii?Q?otkyoZrpBayeBJaDXofkD1TbqLMlvks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146e157c-239f-447c-4cbc-08da4e2601b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 16:50:37.0285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/mY/UzCIJw0t4xBD7Yabzj7SlHU0XhmrEa9S8zGViMutnuzMF7WzEIGwP564ZlX9ySaSVTDGxWaeUF+2sExe1TgQOMG/PirkZiGFd4jels=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3298
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 13, 2022 6:46 PM
>=20
> Hyper-V Isolation VM current code uses sev_es_ghcb_hv_call()
> to read/write MSR via GHCB page and depends on the sev code.
> This may cause regression when sev code changes interface
> design.
>=20
> The latest SEV-ES code requires to negotiate GHCB version before
> reading/writing MSR via GHCB page and sev_es_ghcb_hv_call() doesn't
> work for Hyper-V Isolation VM. Add Hyper-V ghcb related implementation
> to decouple SEV and Hyper-V code. Negotiate GHCB version in the
> hyperv_init() and use the version to communicate with Hyper-V
> in the ghcb hv call function.
>=20
> Fixes: 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB version")
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>        - Negotiate ghcb version in Hyper-V init.
>        - use native_wrmsrl() instead of native_wrmsr() in the
>        	 wr_ghcb_msr().
> ---
>  arch/x86/hyperv/hv_init.c       |  6 +++
>  arch/x86/hyperv/ivm.c           | 84 ++++++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h |  4 ++
>  3 files changed, 88 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

