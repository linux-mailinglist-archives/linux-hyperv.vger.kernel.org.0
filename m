Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AB761B18
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jul 2023 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGYOMl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjGYOMi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 10:12:38 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D951BD6;
        Tue, 25 Jul 2023 07:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTB6tHrOPD6AsprQqb3MNmXGYLgn16I4uyYz1lk7NTgCo9P2hIgWa0tsepqT+WIXI2B7prNeTjBH0OF9AZYjwn3oyuW6mobUa27c5NxywPpLH1fx2raMgBkYt8/VcD8r2otmnkP73pMjRozR/9gzvDqkigj1JFjofIINskPaiReZL0+tGJhKOB1aMT/k+E/3c6m8Png16io8aaJZh3/NuwzJtulZfiICpiWLdRQBIKy32m+HxtzNun0RPaX/Hz1dS3W+i1rKvtxR9mZBUsieuoQHTlEjwElHOH0IxoLVcFxvcFbhwLSsKweKVQgF3djrTm14KR/BnhB0kXc4RnMDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j68gGj13jW5C4lFrkTMrLx45//NLF2oXAIhJq+Wzfmc=;
 b=mcazBs6cC2o34BFnYGrrKDGQCJKg/gAOQy+vIBpzdp1ruSNxx6wwFhCJCbJA47pg9jMClNoVDQZFshYicFR2G2/OZ5XB2S1T+g7opFHRCZN41yv98MBx8AwNgNYOcLUPZNe0daiVsmJIerIABLFAr1lplxygpf705cxMG0lT/hS9y7lYv5TneKowDUINrOL4NVEXKwA5aygFCgzj5eIHBu2y45DCg/ZEtRfZPi33idec+1F+K80BQ0qlE5cdrQ9zyYezhu4T4C4Gk0NELkfWZ4hXW17wtgDl/cP988CubDjn7b0QyXSKJTfRw9GHDwOHQ0X8KDEFQNK5L820jgdquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j68gGj13jW5C4lFrkTMrLx45//NLF2oXAIhJq+Wzfmc=;
 b=jhuTe8eQIhXOAgk8mMMQgJ1xQGLsCyk9hzB1Fu+vT6KhOCcfYHJUYk1oWdF2Je6awy6o5x8qw8s66PuVTuaaSubMKrvXLYios4M7Ph2yvSeT215RngbhtWzRb3qj9Ri9OPFQe2x2gnb4YQO7WkRv8/O/sTQpW3R2Tv7TBm85JpQ=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by MN0PR21MB3338.namprd21.prod.outlook.com
 (2603:10b6:208:37f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.2; Tue, 25 Jul
 2023 14:12:33 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::ac96:bb0:9cd:f4a1]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::ac96:bb0:9cd:f4a1%4]) with mapi id 15.20.6652.000; Tue, 25 Jul 2023
 14:12:33 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] hv: hyperv.h: Remove unused extern declaration
 vmbus_ontimer()
Thread-Topic: [PATCH -next] hv: hyperv.h: Remove unused extern declaration
 vmbus_ontimer()
Thread-Index: AQHZvwAwWLG6rBP22UOG9+LwnPcdxK/KhJaQ
Date:   Tue, 25 Jul 2023 14:12:33 +0000
Message-ID: <SN6PR2101MB1693201F3C3FD2BCDD0843B3D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20230725135834.1732-1-yuehaibing@huawei.com>
In-Reply-To: <20230725135834.1732-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d224c1c9-46d5-40ac-87af-02f1b74cfade;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-25T14:07:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|MN0PR21MB3338:EE_
x-ms-office365-filtering-correlation-id: bdff5d70-e5bd-4126-1607-08db8d1930e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S5+f39UcNjY4TN8Bmx7LQ4nxgg25TABsyX5TscPJkaQUSw43xD0oRkxNeFSXhlAyNRF2zXVqN8bxS3ubWu76NOWZ0RVSknBKerUOQNlwQk9SkK1EjjAwsutSQ/VcoFTk5BA0wFtsr5ZIsTdyjPRN/PbrdmPxgWJCyI9kBNVXYhP+UleGg4YFIRNxiWHzO6MqbxwH4qdyS1L4T9FZk26kqqZoWXarH5JyDddaPlUTFJYYgGNbaE4PfKu1wYJQdFiGGGzcZbQbEbFuBufWenWy4Ekeoh5FFMcBLiM9JYEoREfHsXfsShRW4MY7l3vXJaaM6t9lPib+v0NFljKq2H4/VRBfCeGtQePuHdWOP3geGv+QZ7Ab4/sEH85R7UaP/zCx9ED3FStp8GLSbrbxcWnKCriT5TUpWARy4+tXTb9yx93tqgHwb5HaxI6ZWd7lIiq6eHjpMo29n7bgqqfCkhK85/IkW+cFIVoVPGNMdy+utkp1ZCxWtwy9kAIDulJudIP9GFM2NZWrN0LeKw41qGTterYEZUP15xuyDm9jqbXQxDWklds9MEjZpY72hW2LxkMmvM2ecUb3KEAh7uTNLFxZGVyP3/iSaK54qVz+xtaRWI+DWfWoKrGUoHOIIgXTTFYBIKYTHLPtioObXqR+yzztRq/ELyWaoh73RSv+JbLL+5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(86362001)(83380400001)(52536014)(71200400001)(54906003)(110136005)(10290500003)(316002)(7696005)(41300700001)(8676002)(8936002)(33656002)(82950400001)(55016003)(82960400001)(38100700002)(122000001)(8990500004)(9686003)(5660300002)(6506007)(478600001)(64756008)(4326008)(66946007)(6636002)(66476007)(66446008)(66556008)(76116006)(186003)(26005)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uNuT+ibHic1FQJ5E90kY2Iis6v1f0vPsRYYhxo59UfGZva6MyWcMxvIP4UQ/?=
 =?us-ascii?Q?vRO1EgFUxWUsCE9QsF1CXVOcaqUUxxMH42gZA8C4fD5KkNKekNG75XoUOIMv?=
 =?us-ascii?Q?99BW5zT+Lw1d6VC1qmNBvsA4ZaFCc6AVoj11/dwl+HxUdvCCR74J8qRD84Mm?=
 =?us-ascii?Q?3iTZPniU8GjKEfRF4yABI09zt84ofz+VR3uEZl1il2Q2DQNvWIb0WazPv9uJ?=
 =?us-ascii?Q?QUUay5gUYbBDSpTp5OmH53OI6P5ysQ303MF3ImqaXvL5EBTX7QqRRidvZsUM?=
 =?us-ascii?Q?5IyNYsHnKicHBdLFH8Prc9N/vOd4WnriSsvsTBDHrGc7jeNqrgnD3RQzc+Fh?=
 =?us-ascii?Q?ygcG7rNlIjTymCK4dM/rSo8TH8ILMMRmhiTQNlqcQGtlFDc4l7lJsbn2v28H?=
 =?us-ascii?Q?kcYfdK017/N7Zt91SwnwQWe3MUIsrG3KknRncp464XUz4IP+qJPdwiE7lDg/?=
 =?us-ascii?Q?Ag/mSTeUdVJwuN04THHcnqF+vRfwc8rxqQbONmi84cNkrzsS+zaTuHtX4m1L?=
 =?us-ascii?Q?ZyddFd4n2gZ+wzz5KcNprDRD/4Ox8teD0yyfQdN2lC4naBKXI7Zu9gYQfrjP?=
 =?us-ascii?Q?7af587JTft4Y+q5aTx2il+Xc8HqR7s1flQid+Wql3ya0U7zhcGylEthLHyNs?=
 =?us-ascii?Q?ahwURTojBz437gZBRhwb4sWUqAnsv24wkdV6JM25VC2MV07n7ezFf+SoalJM?=
 =?us-ascii?Q?nHBbbM0YJIyruJEDgwfQRipmtbLPrxgYdJYecdEkBI4zhb0uCcm4PD52UYz/?=
 =?us-ascii?Q?qt3PKGjxDoIxmzUzip6uRSp6khV8zZfzLzbZpwwsxz8l3qoYw+Qq5KDXH7aW?=
 =?us-ascii?Q?JlP/VKABJODyWgRCxi74AlpdXdSXr3HXzAJSAid58h9wZ0M4XgF7f30rnGoM?=
 =?us-ascii?Q?tUIS0y1t2GQ1rNrD+gF/5MCnB97bNRVsaBi8Zq0HEPxICudvSUiolkbOjb90?=
 =?us-ascii?Q?dOvc65lfTIQRR+fYhtOAW57iE7Btvcj84TuJ4cJCsxWXed3FZSXG6qBZUBwR?=
 =?us-ascii?Q?2yE1RO83aXwcWd4H5eXXndfljKpgJGKNp7XbfB43K2BuCXJpwmlm9BLwR7aF?=
 =?us-ascii?Q?qcgcctGEvzaQ8lAwU8DoMBxLpH3FTK5k9oVeVUnVhmn0yU8O+SZ+Pp63e4Kg?=
 =?us-ascii?Q?7Vzk856CEugiZVeWJr0gquzDpoJ7MKsgF2D2PppTKGHIJtRd1u4SrsJmMtQb?=
 =?us-ascii?Q?XdZ5zzNhR7mvndCU1CtYrppD1G2eE2xSHt8XV5bBq4N8R5bbYnm1vEM9hQF8?=
 =?us-ascii?Q?YpRO0CN7ViDt7SYadhPqbCgiDAVdjJxKCFR0hTRc6WM84bRJ8r+C1meguEGh?=
 =?us-ascii?Q?HK/zs0yf7c3RFWMiv4WCtfvAtl0vBZ8xJCgL8zNi3uZW0xVOxpk9c3nvTksy?=
 =?us-ascii?Q?STjomZO2IvqJkSBnrf8esDn/BvlKtXGOa7OpLI2lFDioTn48tOau8cBUl4EL?=
 =?us-ascii?Q?BsThi3r1iP/402dUPv+4lN4Ut7AEns/qvdJT2yYndtuF72g35dFio6rHi2Iw?=
 =?us-ascii?Q?8D+mavp4fEggE+qU2frMppxWkkKvyCoaMMCTctxSVxRsjd6Wz7qcdXzVewkz?=
 =?us-ascii?Q?jAbzY42hLamYT5JsZLnf2E8VNVFbhFWy9uAO3fgzU7xNBfY9V31MH7gFsXDu?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdff5d70-e5bd-4126-1607-08db8d1930e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 14:12:33.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGZ/84Pe+8NpvReKanhMC2/07Nj9OhjWk1MeG+aeSe3dykiZHR8wq/RvwgnyYmxsvDAaOrkidXivPHrg6BMX04dRlf3na5v/6zDQ2/j5WeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com> Sent: Tuesday, July 25, 2023 6:59 =
AM
>=20

I'd suggest using "Drivers: hv: vmbus:" as the prefix in the commit message=
 Subject.
I see that "hv: hyperv.h:" has been used a few times in the past, but my su=
ggestion
is much more commonly used and would give better overall consistency.

> Since commit 30fbee49b071 ("Staging: hv: vmbus: Get rid of the unused fun=
ction
> vmbus_ontimer()")
> this is not used anymore, so can remove it.

Indeed, yes!

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/hyperv.h | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index bfbc37ce223b..3ac3974b3c78 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1239,9 +1239,6 @@ extern int vmbus_recvpacket_raw(struct vmbus_channe=
l
> *channel,
>  				     u32 *buffer_actual_len,
>  				     u64 *requestid);
>=20
> -
> -extern void vmbus_ontimer(unsigned long data);
> -
>  /* Base driver object */
>  struct hv_driver {
>  	const char *name;
> --
> 2.34.1

