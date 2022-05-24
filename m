Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A958F531FD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 02:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiEXA3X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 May 2022 20:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEXA3W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 May 2022 20:29:22 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8308AE41;
        Mon, 23 May 2022 17:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NupLhyP3DPME9lPVRgGtvrYI/7M3on9Imo5SVE+3d+ivogN0xZtxsgE0wUW9c6V6f4feFfKNEYeaVOtvQVdmJuOXifVzohWTTXxphpwx86DIiqnLf+Pqj3UJiix7poffXeTpxKk0eLdFEEVtGqCt340ffaNe5pEf4uNFpXWych0tCsJZJp6mEtcCmBovrr09Q9uCp3rD2wCl7m5ujd5bmRlsF2ae2l0df4tMMmQzIDrB3Hge1zOQjKqsBwZI/YtkxAYDhNKGKRTw2PPKpcMbwM97fNcHfoXiFkCJpiWDj18UxHaEr/KKNFLZUWBigIC+vKS6VRaYXL09PU5T6hBV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD9Oi9vSjSbK/5grgozcXPJmANkftv0CWTUe/G5enXk=;
 b=mgIoqczSPIy42naxPB7o/XjoRPG7su2U4Y+wS4w5o5tF//EM9sde0sZW6g74Owt1sgFXSd2eEiqplOTYxJshh6KG3KGjhMDBGCyINHbAFzUp6ZeFGcoO+lS/H9Ip/XgYigMxm2ntENS/Hfj0Sl7YXKcx8rhyfeXDTD6+QUxImdai2yf66Y+U8TvrSAyOdRBRBu7LQcb9ZJWfDWoWeYu6eEGrHewcJ0QXtPlbQVvfAwOUONda8EwKRRd/z88uwaXgvWk9LRSeh9NtPj5NyVnadmlge05KHeWcrOGXeOF8OflDZFlQhaiMSTMQZX2NXAwKgIjN+Bh2SQ6E9UWUSYSybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD9Oi9vSjSbK/5grgozcXPJmANkftv0CWTUe/G5enXk=;
 b=fM/xllqWvDsIwM+ZO1akKAONvaQ1opKf4Vm3frNgrN5LVEtFMteMkQz7HTn4DozHcncxq++Mp8PkmOdHU2YW4CuQlTOe9H6iM1VNwueIR5midM+J0ExDR8u+TcIRB0/vudiMa1nsEvTvQU0lciiC6p9q3j+GrXUkZ9/8fBQxX30=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by IA1PR21MB3544.namprd21.prod.outlook.com (2603:10b6:208:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.2; Tue, 24 May
 2022 00:29:18 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580%9]) with mapi id 15.20.5314.003; Tue, 24 May 2022
 00:29:18 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] hv_balloon: Fix balloon_probe() and balloon_remove()
 error handling
Thread-Topic: [PATCH v2] hv_balloon: Fix balloon_probe() and balloon_remove()
 error handling
Thread-Index: AQHYaOCSNsDFis8MBkOPc7b1F2CeM60tODog
Date:   Tue, 24 May 2022 00:29:18 +0000
Message-ID: <PH0PR21MB3025868F7B32571C7D009BBFD7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220516045058.GA7933@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220516045058.GA7933@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1dab3ed3-1df2-4e16-85b0-2dfb88e2c37e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-24T00:27:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6d23c2c-5a69-4b3d-b077-08da3d1c70c6
x-ms-traffictypediagnostic: IA1PR21MB3544:EE_
x-microsoft-antispam-prvs: <IA1PR21MB3544021B1891CDC80870632CD7D79@IA1PR21MB3544.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IzLHpDHU2t8MuZUj1G+pyudIdyITD3tQcRE/IhkY2N5y6qHZ4Ry1Ct/RI9+tP+axxMOdQa83NvrPY1YT7AS2F8KLNhlPRNMUPe/Ocgl1XU4/l3T8s7NVppRth2ojsk1necwMGqyNNb3l/eDDs2RTiCgU+Q+AKfw6KPHgfTbIx1Y59vp89UvBz0s8tpsVy4LpBl1e2pzu5s8op3t28khsg+p3DmbV6qEJ/lZS1OnwjyzG48h+G9leQsCyIN8gFi2V05XBE/5hzHOe60aQHzRXUaDlpRoGNRKr+AzpCuD66vnINfOY6fbV6W1o07R/wsj4O/VDMfwUupsWFDy7laK6HoErfEFdokvSVW/gZXWQQGZAbRci16B2hsHc538sb+k5TXxrZCJIBIDrGdJhpTBsGhmtKs31SWXzvvF9K2EOCyzJSWt71h2Zs1cXDrU/l8lBQTTLIKpTYTW9rqytjQZgx5u64gFi8O1Y3HCFina/Js87XG09CCAoWhGnekdxwAN9YCOq1JKX1m9uSGeynbfdUpE2x8/CgCiJaZByXRdukPC+mVeB4A8PjSPJdhb/eMmwi89gQy/poMSyJKYzzptRUOoscmD/Fa7A2etD0HLCmoosh8kPYiCH9DBMQckO5Kg7nSKXLnCLuLiz1vz6SPdDSNESCrvXQlOrge9B07ijeRni7P9Cuh8DJ4CnQp6vmxnn92tVX+qqF9vJFi3sG7aZf29GZQYGd9aVHZJojhRdpVFgdtTpuZaKpmn22sOH0/MT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(2906002)(110136005)(82950400001)(6636002)(508600001)(55016003)(316002)(33656002)(71200400001)(83380400001)(186003)(8990500004)(122000001)(66946007)(6506007)(66476007)(38100700002)(66446008)(8676002)(86362001)(66556008)(82960400001)(76116006)(9686003)(10290500003)(26005)(64756008)(5660300002)(7696005)(52536014)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CP8V67dIZVIo+/pjOkYIrf44jZCEAkzpFGEIa/Ky76nuQgQYF3CWiqCtqGHy?=
 =?us-ascii?Q?jyvXV3skHa4p6d3AmdLFOYZFugB6LXuj/EgjJs4fdoS6+DI2oEPpsySBJmRc?=
 =?us-ascii?Q?mZpzL7dGzfKDvpCguSaZQ5SymCC2nFlbRUHt9ltizdGlCpNNk+4USg0SIm0c?=
 =?us-ascii?Q?7Fg/szGADybszBGmqM28ohAZB/nqyho5ktjV5yymHnMTDW6JQ+ZUD+CHAq/T?=
 =?us-ascii?Q?6WYInho/mbs7nTHVm3SSFm1wrQ3yDoy34OblX2xSUlImDIr53bx1nf4sZbmS?=
 =?us-ascii?Q?VrhgJDHPVv456sO8cQpWxhSb51UYEEgCCLcqLmDE9gzH+o2P2a01Gs+8qw/V?=
 =?us-ascii?Q?j10rYvf+hErNzB3bF8KcDoyfUbqGKssWCNYs5D3In5qqpW+MkiS6X1UoSDjI?=
 =?us-ascii?Q?8+I4zmiDxj7uy+vFygb9waF4Qd72mLPZ0NrwRimjEUk086kCYWPcvmkHKt8l?=
 =?us-ascii?Q?8mmnI+ARu2BqANm10JorWiIPTyAx5XRmzXQO0BPqdBM/H9EGSEaw2XBe/Hyi?=
 =?us-ascii?Q?an5GhGCOPd0LCclNUpfmC/oDEjaPPzNfVS4nxWgCA6ND0cEbGGJHIQsuSf0y?=
 =?us-ascii?Q?/kCBcFZnpz9Q9NAOpTNaC3MYarwFldF+ScJAcD9mdnqmYernc4yiNBwz+VuZ?=
 =?us-ascii?Q?a5+JtuuK9ViLfc2aLZB/5MStjPR33iB2skm22xu/6Tc35TaFViTDqyUCx/Ne?=
 =?us-ascii?Q?dD/6hmF8qoxdodyxax4x/2x11VI3QxvqawJYz8StB/l3SQg6Uw0knRQqKmNq?=
 =?us-ascii?Q?qKxC7y4LFm7FnSEpbyQ1jqz3STbGN+mZTP8w3Xx5FeBKo+ZbB/mr3LtIQnDV?=
 =?us-ascii?Q?YteophXWdN4h23pNTHO/iZGVzuGo0Xguo6ADV82+RWIQYs060JbO96iyUGQN?=
 =?us-ascii?Q?cm2E/4503hDiVQNPowerfYiWsbBc2xcF4VqbsbfVc7Sp2WZw1AA3SsXeSraH?=
 =?us-ascii?Q?CEdYciDKE2iRs1E03qRmlwnohpO/h2BtoBsZmu0+zQis9mvsJKBqKpw39NYo?=
 =?us-ascii?Q?Kzuw/oi2kQYPvzgFzavUydFEgjomLi2HmaZyhA+aXB3mxSgbazU8DN74EIiM?=
 =?us-ascii?Q?7R8J7fh/IJbOcZmeEv4unTC/TUG5RbVKQuTGFz8UEWtmGTvkaKGFWoSMMrzA?=
 =?us-ascii?Q?cYpRr1fYS3+u35eFPKxhhznyxsIOiHCxfWH05+LSkkR9F/duvH/quQqMQUP6?=
 =?us-ascii?Q?CtDxesJyQdccKZgBJvmtY8QV6PbelOftEZ2nrCKWttBvMf3XTSFTWx0duPa2?=
 =?us-ascii?Q?CIgT3EClSXX23hnwbf4n/j47bvwQ6h6EOTWXhnhJQ2dERCqtjE8GM2S/zhpk?=
 =?us-ascii?Q?Nb2oI57bIgTxpmkrRM/5QIHH83HkVFz07LGx8/kvm+uCPQC8Nb/A8hpXla1s?=
 =?us-ascii?Q?Yhgz1rVnj7G4fFjnxVnWr41LeEHy5hPFhal9NzBR4n49NuQQ/SvTzZqClNvu?=
 =?us-ascii?Q?H9YxTKBwehyRu5YCe0+pZQgPvCTyaxqw1fFbiv9dxlrdKDTK0hjUuX8LX4FK?=
 =?us-ascii?Q?M5GkhjLIwqj1xaOZ9Mhdhg6Q89wGIdefjgB5qNk5ZcOkWuQG95uKAh03mEyc?=
 =?us-ascii?Q?HpZPoa80U8V44s1dgLQQmPPQ9GddllGN94tXpN0WHxOAg40GroLEPqQ+UXQ8?=
 =?us-ascii?Q?7wNx+LD4CWxNbdIGxmCF/BaFoi2bk5s1nmI21SLUP88/uh2eItXVteIliLdT?=
 =?us-ascii?Q?AgglDLeslMogDXUd/88PwZT1+1voAeRKBR7dTpXE9HHHbdlgL6EemM4Kcjjt?=
 =?us-ascii?Q?mCylJuPLeOvUpNv0JY9+5BjqKqtfDS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d23c2c-5a69-4b3d-b077-08da3d1c70c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 00:29:18.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+2ExgWoUlTQkDGZBPiZXEeRtigvDriqycNzBLDMknFCxLoTAdQ/YvjJ/bl5FxjCVasO0moUgu/p5R2Ou6Z6Txe5NXOrpSHUVnhD2p5VtHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3544
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@linux.microsoft.com>
>=20
> Add missing cleanup in balloon_probe() if the call to
> balloon_connect_vsp() fails.  Also correctly handle cleanup in
> balloon_remove() when dm_state is DM_INIT_ERROR because
> balloon_resume() failed.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
>=20
> ---
>=20
> Changes in v2:
> * Use a goto instead of inline code to handle the cleanup
>    in balloon_probe()
> * Add a comment in balloon_remove() explaining the
>    cleanup scenario
> * Add missing disable of page reporting when resume
>    from hibernation fails
>=20
> ---
>  drivers/hv/hv_balloon.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index eee7402cfc02..98fcfb516bbc 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1842,7 +1842,7 @@ static int balloon_probe(struct hv_device *dev,
>=20
>  	ret =3D balloon_connect_vsp(dev);
>  	if (ret !=3D 0)
> -		return ret;
> +		goto connect_error;
>=20
>  	enable_page_reporting();
>  	dm_device.state =3D DM_INITIALIZED;
> @@ -1861,6 +1861,7 @@ static int balloon_probe(struct hv_device *dev,
>  	dm_device.thread  =3D NULL;
>  	disable_page_reporting();
>  	vmbus_close(dev->channel);
> +connect_error:
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> @@ -1882,12 +1883,21 @@ static int balloon_remove(struct hv_device *dev)
>  	cancel_work_sync(&dm->ha_wrk.wrk);
>=20
>  	kthread_stop(dm->thread);
> -	disable_page_reporting();
> -	vmbus_close(dev->channel);
> +
> +	/*
> +	 * This is to handle the case when balloon_resume()
> +	 * call has failed and some cleanup has been done as
> +	 * a part of the error handling.
> +	 */
> +	if (dm_device.state !=3D DM_INIT_ERROR) {
> +		disable_page_reporting();
> +		vmbus_close(dev->channel);
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -	unregister_memory_notifier(&hv_memory_nb);
> -	restore_online_page_callback(&hv_online_page);
> +		unregister_memory_notifier(&hv_memory_nb);
> +		restore_online_page_callback(&hv_online_page);
>  #endif
> +	}
> +
>  	spin_lock_irqsave(&dm_device.ha_lock, flags);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
>  		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
> @@ -1948,6 +1958,7 @@ static int balloon_resume(struct hv_device *dev)
>  	vmbus_close(dev->channel);
>  out:
>  	dm_device.state =3D DM_INIT_ERROR;
> +	disable_page_reporting();
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

