Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC366F8D26
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 May 2023 02:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjEFAaB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 May 2023 20:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFAaA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 May 2023 20:30:00 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C474C19;
        Fri,  5 May 2023 17:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fayl6YejUyhM/kRcyrzi5WwyKGo9mu71vpDujFEP0Kbb3ojIelwwgO5TKiFHSwtG41CjzCsxKCgumQ0p35rdyGalg5bnWfO/NdHs6K+ubAT/koqkhc3w5U1oNglbq6kbua//K8HjULo9QusHhDTTiExTzN7IatWPtaCgPU5iJXcChtRd7fNHQnNj7yb8QASfpAMLYH5zsso3smNH9tVS71p0LH3vIRUufNuALG45BwB+GLkLjQIvlPnYs6u2Kernghx1/yEZg5hGC+RChRDTi+77l6zRjOgEwGNPJuknXNp5HtNatAi3mXgG82pwiPG8zwOh6ufKerqrv78D3J6u9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF4CAJ5NC2TGmIVTdPbcZsE6/4U9oLrlsBcVJ9H0GpM=;
 b=ESheNBdqlJHjwkqPb9sqnpVFjtHU32iAj9ntBSPVNRRALpr4P2ApQj+jgOSBt7Jn2kvlwoTzfLhGptLMsUUZjX7qZVOIaOZD63rX0j2fYL9fd09/3rETttbKtj1/d7VpUrB5J7DtYzINtDfQs8Bn8ve+P6FffEZZjH5xrNAneGyEHgWUVgCAuE2wZS7W2aTWCFQic50SgZHMB3iZQrtcuO4cNOjSmh/pDGZahyyrcb0iT1F3bc4MPFBP6KYjL68Mvrizl8HdGrMTLtIcIE9eMj0ufMzOhM4/mi9WousNq21ZbTpr76Cj3rf7DKnfJgOOFb/DjrWiEHLCClMx6k+s6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF4CAJ5NC2TGmIVTdPbcZsE6/4U9oLrlsBcVJ9H0GpM=;
 b=XxV+RaSUM+62Jt01ZaFiVGz2frXHs8+i/wsXFw1hqu75mkbcZWxoolxyEhpNkhbU28NZKkeIbJqVNsafsCE0Lpnlk9kYl3xwbSPD6X3W0RUZACRqfmQFXgYVzbOqLy/kJ5+EGA/YMBu0kKyNl6o6uNYV3DANd8v7Ft1RDDJ+DTI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3115.namprd21.prod.outlook.com (2603:10b6:208:393::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.0; Sat, 6 May
 2023 00:29:56 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6387.012; Sat, 6 May 2023
 00:29:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if
 hv_synic_alloc() fails
Thread-Topic: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if
 hv_synic_alloc() fails
Thread-Index: AQHZftmyZlo283HZ4EioKMxfwa3sj69MY/9Q
Date:   Sat, 6 May 2023 00:29:56 +0000
Message-ID: <BYAPR21MB168862E4608ACC6F734EECA4D7739@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230504224155.10484-1-decui@microsoft.com>
In-Reply-To: <20230504224155.10484-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=07820dd1-dce5-498b-ae13-f4f0ea1ee9f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-06T00:22:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3115:EE_
x-ms-office365-filtering-correlation-id: ee4c00a2-5e1e-4903-d734-08db4dc904aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9SXFC6tWJnuulGQHamiNtpcl+WFqRl4C64lhILxb4nCjF2KVa3eCCvU6m/vj10ZXKji52q4KFo1HmVkSE92Yl1k22lTxrkH/+RpeTuIKDTTRugDm8kDNVGy+NI3WUMRCw1jMfSUUVoFH3DPzmwRzpnF35sfQ8UlxRu5IriEZ36UtDnE0c5ma5VqCQ2PG4oyoj1ocVUYO7V3qugOYZioBemkQD2ubYrkL5ArXdn+3utFdu5/WIUU115/ooNbm71M+2IxKVrp5yGpeDIEfbMWbh0R4+vkwzVY9/SSxGTTeSDC+DbN2Y1OO68dQMXCtRZ4wtPhsCFw3zLYJ/jbgXZ+5Y9cWPeVYA2GccxxSmTVJblrMQXOFiFnw6PIeQCFuOWx1+wb/vJF6uvHWLeR2ntyNWdwbR4aTllsK1bMEdcyyl3lTQcfLecIAl6YNIdDbt+9ZuDuRU1AXAY2cV71L/h4E4nKLY6yOS9JE/gDDhbwMCmWw8dESl6H8mpqZUOJ8JqWouL0Hnp6x3cu1LjSPaGE3x0g2zutuMP06LhMYQCtdoQm2gB+osAIandVzGlfodoFrXdAash6cw1nZ0IpW8qQGZvYehB8X9pq4TxmofByRjqdl7/2XIgwzZwcLGQSxTDd3EFVq1LbQs3GBMWPEth79Gm76+xpmIkxg0mjjiK8UI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(110136005)(5660300002)(52536014)(41300700001)(54906003)(76116006)(66476007)(66556008)(66946007)(64756008)(66446008)(4326008)(2906002)(8990500004)(10290500003)(8676002)(786003)(316002)(8936002)(478600001)(7696005)(71200400001)(82960400001)(82950400001)(83380400001)(6506007)(9686003)(33656002)(26005)(55016003)(86362001)(38070700005)(186003)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WuflK4A5M1+1Mz5axjsRs6GLNWbNNHRXqTlQYNXbSuxq6hjUzNSrWH44iwK/?=
 =?us-ascii?Q?nC/lLm3Zrxa1l5t/RFOAM9rp6eY3cfFnfQrO/auVj3HfrJfz0VUu4xphw4I4?=
 =?us-ascii?Q?C9irGzGuDBsx2cuJu4krzlz4IEKEZ6QFNd4HcZ5UMETWHBZey52JZdhLF5N3?=
 =?us-ascii?Q?Zg/iwfEDrSGj1bZS7wnIs62RaGOkDCypJ8fZZgRo02rKa6Acz++RLMMVcLo5?=
 =?us-ascii?Q?g3mh58C7dywoitOEW/8z1cC4PiPJc2rAaIGkNCJZgfD1Epp+4GnVJhn2vTnr?=
 =?us-ascii?Q?rJuZj5xHXrCvqhYCwjIPvBjqTU/bwLbQFlCE2qnGzusS95ZzQRGsAaaQqYCU?=
 =?us-ascii?Q?wQX/JPKE2d7sY1QAU3XcrKUJQ6J+9VO9PxUbVG32MgJT/2MRHWLFX6kM7oyz?=
 =?us-ascii?Q?ivgvsUFLTXzthRDAGjSsyulzqTKNJvDVsZfIbWK1FzuIBuf4Dq6qZHu9xSpf?=
 =?us-ascii?Q?q6X9gklYEcwtOEC4htcefvMqpxoocM6mgi7fP2Vw1nP6t4LwBcfrK9FAlNXL?=
 =?us-ascii?Q?ivJ1q29zF9mcV4S/2oRYU1H03VbKK6kvq9uafEq8BctcSNl/4/DbDu1IFy13?=
 =?us-ascii?Q?XcUWECsIgy1c0YQID13sKDkGkxqs00oAUtloSiK1WUzqYcvJgcIxol4vBryX?=
 =?us-ascii?Q?QQSTaIqACNv5b8pLezL0cVIMKwxBe9gaXLaVfV3GV3nK4CkN3mH5Ewivyynr?=
 =?us-ascii?Q?tjBverxlGVeS+zf7Lq8o1gIYgJkSPB25j0Mlq5Y3x/mEoGk4bvFPCSCbyD/F?=
 =?us-ascii?Q?nbt2QNrVs6laE/2F9B7xPmvpUE7NxfG/ooP0pQdEdDE8PMtVQQnkHrzovhr7?=
 =?us-ascii?Q?qmgkmahf6peM2j9ToJ+c0LloPp2azKjP19vZtq+1TIrE61S8CdWArfuyzY8Z?=
 =?us-ascii?Q?ugEpQJcAz8Po/fuLJM0uwBcWVQhwpt+r6o/+N2db9Wu4y/ZcizWHpZtOYx3H?=
 =?us-ascii?Q?Z1crOA2+f2PQY7y4cIdsnQtmfFAeRGa7PHiD48goeXS0R/bRczbG3l8MUTq+?=
 =?us-ascii?Q?08yUVG86r0ZSrpf7VpQlQqcCamC+OtAIt50+N251XQd2cb2XlPZyTLF+vRmQ?=
 =?us-ascii?Q?M/KKggfWkQjVjQrINVHwh+GN6+abJLblBGdChrQBrZO9I37fYAtNtoPcGhhq?=
 =?us-ascii?Q?WFaFcWG6gY8hLhzomEegBdTydgW+SO9mEqGyFjJp8dbxCxUZ5ZArjsGr2xVs?=
 =?us-ascii?Q?7fNq9Q0cKQZfaRYjsxIDj0M6eR0rtkCnn+pdN3JXh4KrAhvi/QJE6aJcd4Qj?=
 =?us-ascii?Q?OwpLeVBCMWyJBDXjplWwY2yzleIK9s/BnmrB8aUVTR+eDx1ReGQCaNK4OAtI?=
 =?us-ascii?Q?xyUbWPo0lauirl6asoo7W6Rc4OYh2srLJX2ZQV41bUd1t7hRhdS2NmhrRmox?=
 =?us-ascii?Q?unoubn6QSDS/Ox2JWy5ltN3vPpyC/USz9qMjM+0iQZZ4KfNcvJakN7TV4tBm?=
 =?us-ascii?Q?EdQ3Q/95+3Hs7KxyqZS+/B8W+xkNJpNJdJ15clxtT0Id2qm9JcLMNNPV68E1?=
 =?us-ascii?Q?4BXK0+tClHGNbp+F2MhnY9GotHAWABlxC/BPTLeKXYzomrETNj9qyHXCUDNp?=
 =?us-ascii?Q?mkIA89X4+aPD1EuZ8c2Xb5X+kX8EPs4EcgxmgM+fJUaSqfa9dyVyerjVPI3E?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4c00a2-5e1e-4903-d734-08db4dc904aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 00:29:56.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FPIOq1vbb1gHzK8NMxmy/CXeWVbAQHDgnqxHd5XzvhTHPNmgq+Dc/Dc2zkmc5AbhLCkTTHyDKdMXrFkj8cfHhzasagyaQ816HxObj2a4nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3115
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, May 4, 2023 3:42 PM
>=20
> Commit 572086325ce9 ("Drivers: hv: vmbus: Cleanup synic memory free path"=
)
> says "Any memory allocations that succeeded will be freed when the caller
> cleans up by calling hv_synic_free()", but if the get_zeroed_page() in
> hv_synic_alloc() fails, currently hv_synic_free() is not really called
> in vmbus_bus_init(), consequently there will be a memory lead, e.g.

s/lead/leak/

> hv_context.hv_numa_map is not freed in the error path. Fix this by
> updating the goto lables.

s/lables/labels/

The statement in commit 572086325ce9 was true at the time of that
commit.  But I broke things in commit 4df4cb9e99f8.  Should add a
"Fixes:" tag for 4df4cb9e99f8.

>=20
> Cc: stable@kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 59eb5fad12e7..c41e6ad0cf64 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1525,7 +1525,7 @@ static int vmbus_bus_init(void)
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
>  				hv_synic_init, hv_synic_cleanup);
>  	if (ret < 0)
> -		goto err_cpuhp;
> +		goto err_alloc;
>  	hyperv_cpuhp_online =3D ret;
>=20
>  	ret =3D vmbus_connect();
> @@ -1577,9 +1577,8 @@ static int vmbus_bus_init(void)
>=20
>  err_connect:
>  	cpuhp_remove_state(hyperv_cpuhp_online);
> -err_cpuhp:
> -	hv_synic_free();
>  err_alloc:
> +	hv_synic_free();
>  	if (vmbus_irq =3D=3D -1) {
>  		hv_remove_vmbus_handler();
>  	} else {
> --
> 2.25.1

Nits notwithstanding,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

