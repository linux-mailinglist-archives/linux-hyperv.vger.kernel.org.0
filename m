Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D64DE906
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Mar 2022 16:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiCSPbm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 19 Mar 2022 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiCSPbl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 19 Mar 2022 11:31:41 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5775B3F7
        for <linux-hyperv@vger.kernel.org>; Sat, 19 Mar 2022 08:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNYIA3u7bdRCCDArJTkf8u2MZ221walUX2sq3EKjQ5VvpaEL8ia0fzqkydDyitDqT374zKUjs7HOWDiTIBos7SyZ1qBrllyblcn8zkfHKgVAgahE76AtD2Izng/NeLGD0KTH0PmWn2mMEMuFhEBQsiVQwRZmNcb/uaP5cA9H+wj9dRK+b0b7cH7uOzAY7M+TEIgUlkDZCAniw4ffDYkoALx8D8zphRLSVl0ThUmQLnFfZ1V+O7tW8cexkXBXeNcWKdmWU6D9lw1H7Pl7Q56rs8jPXIQoonru37pVWVzri3yz1rqUB9E7LcPaS+z8Ke77W+xVMJhwMaWfpXek2Si66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1xKr6Pi0EDjvVF3asDxDQRQOJp5cYqf+JPSqvfrJ/M=;
 b=QqJEBsnnOPeKcZaT2l4ASACcGqWwvn4FVDm2lgHnVlVnJG5JEeMLUXafsAp1R9HXHBGpwV29c0y50rsPIFwJz7opP3SRUYhtwJdGnyIPTRp6CpkZPtXSfLfHf2HJ31gIwCFxitoVfRMlHr7auxPQ8ttjkIpFtCRuwu5V3BHi3MR/v/eoc89ZpdXYMxLDUZTxtNm2ZGVow1FYNIRKI0AyCAXi04CZUwT/WMw5xBBZMMk+iWuwrnchlvRSkVl6gyUT6NbjmzFrxQb02N+B+c1CBN4M90hXeTuTUdO4ibQTbaXjYirqypTOiUsAcSX+6XhPA7/c4GfcnrreKrALNNNeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1xKr6Pi0EDjvVF3asDxDQRQOJp5cYqf+JPSqvfrJ/M=;
 b=N7mu8WrY48SowOJNB1VE5E6ypO5tKnFD3NNOTVgKOgYaDmDZgHRI6O/LZW4stZA0o8OrA7Cu8kmBbAMvIH1Uy2nVJarERjQSwkWbBxIXdWJpbQkT17bLoGol7PUA9eBO+tQpQNBaolaOBxfWkhP0PnZiyVLqvXHdsMna3N0CGUQ=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by CY4PR21MB1554.namprd21.prod.outlook.com (2603:10b6:910:92::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Sat, 19 Mar
 2022 15:30:17 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%4]) with mapi id 15.20.5123.001; Sat, 19 Mar 2022
 15:30:17 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix potential crash on module unload
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix potential crash on module unload
Thread-Index: AQHYOKxWeVm5mgPNE0SGpyVdVxshzazG2o6g
Date:   Sat, 19 Mar 2022 15:30:16 +0000
Message-ID: <PH0PR21MB302540E78316B06885EBE72AD7149@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220315203535.682306-1-gpiccoli@igalia.com>
In-Reply-To: <20220315203535.682306-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fcc118b-f781-42c4-84cf-222d4163e18d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-19T15:28:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d46a7a24-28b3-49d6-4ab6-08da09bd5edc
x-ms-traffictypediagnostic: CY4PR21MB1554:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR21MB1554A4546D533C36963A9526D7149@CY4PR21MB1554.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/YNqyzE/02EWoojx7GJneKbB6I82NyulWyQfMqm5yrgMDmq1nuI5HRNuMEkIU0N3o1q5zpvRwjW8UshHG4H0vKTokaq+r91wWxmeoPKmIJtwGhlw5A4l75pwwgvcJfjCZODhQR1ezjn6pHf5hX3CqMXI0LZWBto6lvEsPnwCVFR2qYEQQbn0ljdICTYo36v8XHKoVF5P9zwxcobK1CNo0Z6CLYhEFjTABUonQ3KfBWtToKbpLgRMFbyonYf1Xr1qYjI48Z7Z/59Ah5fkD45gCB0eL3tJVF0yIQ3+jgDGOw3lJ+2Y4RZc37DIig08GntV8/VJf2lZk0Vjw4bT7Mt0zHFLUgB/bDeZIanDm2EqN9zMSIuaQ+pD/KI56dlgXVFIHV7v+AQOP1u6aeUm4Z8Fj+h3H2JHKo1VTd26A2CEbBTVGUtsynkmSFfbc9Vi3PXKEofjhwE597TPC75halRi6kljDjupRaFSy8zfN10dddVNfL+zhr3IovHlVRVa5jewd0vrG4jzBjc7+QOcr1aeezIFaZXyqQ0c/Ldkg1dEKCwjJV83UWHj98CVCu0wBMUUgm/NCG8dIsCPFgBDD3YgRMG8ubqg0eC1gTZPJBYdxcghERiyxNJcvUIbdz3Ug4WBV+yS4DprK/ItQjDepu0v6Usxqee8sccmXEIJdRFFkNfwnjtKSJBA3zvRkkTatqaRxELVJSiMzK2wRUZpXhowE30pBdhgRAMMQ9mDnDt7suGsDXAFxOwNf+LrvmVrhjF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(4326008)(38100700002)(2906002)(38070700005)(86362001)(64756008)(66446008)(5660300002)(82950400001)(82960400001)(66556008)(33656002)(52536014)(8936002)(76116006)(122000001)(8676002)(66476007)(66946007)(83380400001)(10290500003)(71200400001)(316002)(9686003)(26005)(186003)(6506007)(508600001)(8990500004)(7696005)(55016003)(107886003)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLxPhUaVtFEze/vbzm2ekahN3kNICon3PtI/H6fz3E7g41zRdCXwhEReQupX?=
 =?us-ascii?Q?CYElQd15hzScFXLZTZFyq2fuwWxr8jGShi5XnVe5oR4YBbxPEt7Z8wevg030?=
 =?us-ascii?Q?fIUOSQE8ZmozHvrTkTdEMYfXUg5JiEgzm9p6Vn4G4bVFoDiTYclMKIipMgXj?=
 =?us-ascii?Q?TknqT7VU8IBTXAsvZVIZ+PIgRypYNuY3gbO6WXzGY5fh0XFwUWyeZqmgZRPH?=
 =?us-ascii?Q?xsrFvLxroRwTfQwWA/dtZx8f5U/mQiljYViP7xWfuSgMnjgVAXxFABRzkTtV?=
 =?us-ascii?Q?0W0e1yoWBlBgsXAqJBUVKIZJnagjrvyCxdK205S3iRZ5x+u20KfQ6cuRwR/4?=
 =?us-ascii?Q?VgwBfu/+HeeLAUomI/lHuOxcX/GkwDexjBKAXjxi83/swU1loDRE67AxDyh/?=
 =?us-ascii?Q?SlOD04pvR5MnyGwqgbH0vFpWR0QxQLQ1TDMsUj8fycjc2oAuO8fIJ0PqR89W?=
 =?us-ascii?Q?EQrfPnpbNHgDRTyTT6TaTgFzou3PhuffBXGrF6WApAhr2OZdIUn4hOSGpKHS?=
 =?us-ascii?Q?JPpnoTvyTTMzMvYuwYrl3Ztd49lXQg38zh9QVysadaFMUAo6FzEBQqdYH0qI?=
 =?us-ascii?Q?CHbRyOL1iXut/miETEGz5QnkTgxJDuiYQ9L++eYW+cUXeaF39If3E+agnjxC?=
 =?us-ascii?Q?PstJEkt6lFNzIoY/F80Bdbi91ta6ZAKRVARlEuSl2+c7aAXwd/T/We1BCobh?=
 =?us-ascii?Q?lY0cQaKfezbtlWuVGKLKcZ0kUQKRyqEJzpIwdNsBulbT1C1cD23cCYr6WhWc?=
 =?us-ascii?Q?rmR27MNuxxbaKvRqz5Yp7V2vP+AZ33h16b/6yGzGjJwZzmjuexclGrJAOo2r?=
 =?us-ascii?Q?w7fSny2PzmVhq6odYsrRsC1MgZGB9/0yzJoZyqIH9bTRiUk2OEcDW/28ODDn?=
 =?us-ascii?Q?q9pnd0RN+HmSxuPQOzCcS7N9Bbbr14bxopdEoZoaMpZnImBFyjIhITbe1Duo?=
 =?us-ascii?Q?xrzcroChCfZQJhVJOLIUGo6Q535aHAtCJyTTKpMzibFn9Rka9eUx4X6Dt9sm?=
 =?us-ascii?Q?C0QeY/peK9MXxhPzlSOiv5LOXH9fAZkAGRFEkR6ZPCaWBGvITRif8T3qrFOP?=
 =?us-ascii?Q?2q/WBxKClHD4nNrhEW2MRCFMDP6zb6soQbKwZVXg2V+G+b2t+SW7upPZkt9K?=
 =?us-ascii?Q?Rj/V0k2Mc2r79ug4RFnYWrJ49+nJA7hnQ8rtfBF9U/rSbyeYvXCEQj41uavQ?=
 =?us-ascii?Q?rnEXFYinFFsuWirPJ/8JWxH1p5jXjpZbJS9bHD4O/lEk4gMH3sdbaHDMwMPB?=
 =?us-ascii?Q?WoralaziT3/Re5fetGp2A1FmXWCGseK87acrEBx4QExD/t/jPH0oBAt4D1FJ?=
 =?us-ascii?Q?IQzRBCScZ5+mpXQ9qGuBKczByyfj9FN/Rn0SmPiC7ppP/QJ/K3jQlnMPM132?=
 =?us-ascii?Q?iGXIbMbYZYnQFCEPHJZkgcqb2aoqHn+WjfEQ/KwdV2/z3N73ogZ0JenrBAYL?=
 =?us-ascii?Q?fkx6JmmJl2pxzf6Jp/fTsZIFYcuM4j7R5ZmBUAp43R2NpnbcLmv4EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46a7a24-28b3-49d6-4ab6-08da09bd5edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 15:30:16.9525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSiOl8ln0cdik/5sutlQIUbKOyhc7J1NPf6+/Uk74fexH5H88i6yIqsHmrirc48cbX1DQ8ZqflGE/n5XIBl24V5TfRqS/WO36ORFCFwdJSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB1554
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Tuesday, March 15, 2=
022 1:36 PM
>=20
> The vmbus driver relies on the panic notifier infrastructure to perform
> some operations when a panic event is detected. Since vmbus can be built
> as module, it is required that the driver handles both registering and
> unregistering such panic notifier callback.
>=20
> After commit 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic
> callback")
> though, the panic notifier registration is done unconditionally in the mo=
dule
> initialization routine whereas the unregistering procedure is conditional=
ly
> guarded and executes only if HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE capabil=
ity
> is set.
>=20
> This patch fixes that by unconditionally unregistering the panic notifier
> in the module's exit routine as well.
>=20
> Fixes: 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callb=
ack")
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>=20
>=20
> Hi folks, thanks in advance for any reviews! This was build-tested
> with Debian config, on 5.17-rc7.
>=20
> This patch is a result of code analysis - I didn't experience this
> issue but seems a valid/feasible case.
>=20
> Also, this is part of an ongoing effort of clearing/refactoring the panic
> notifiers, more will be done soon, but I prefer to send the simple bug
> fixes quickly, or else it might take a while since the next steps are mor=
e
> complex and subject to many iterations I expect.
>=20
> Cheers,
>=20
> Guilherme
>=20
>=20
>  drivers/hv/vmbus_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37e87f3..12585324cc4a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2780,10 +2780,15 @@ static void __exit vmbus_exit(void)
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		kmsg_dump_unregister(&hv_kmsg_dumper);
>  		unregister_die_notifier(&hyperv_die_block);
> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> -						 &hyperv_panic_block);
>  	}
>=20
> +	/*
> +	 * The panic notifier is always registered, hence we should
> +	 * also unconditionally unregister it here as well.
> +	 */
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &hyperv_panic_block);
> +
>  	free_page((unsigned long)hv_panic_page);
>  	unregister_sysctl_table(hv_ctl_table_hdr);
>  	hv_ctl_table_hdr =3D NULL;
> --
> 2.35.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

