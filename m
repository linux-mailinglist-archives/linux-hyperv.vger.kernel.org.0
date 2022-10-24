Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1F660B58E
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Oct 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiJXScC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Oct 2022 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJXSbh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Oct 2022 14:31:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021015.outbound.protection.outlook.com [52.101.52.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB94D247;
        Mon, 24 Oct 2022 10:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEB2c0cPMQep1UbsDpbR5gdNZHQ9W7Asis/fEIOy4LEK1vUMBVPm9rraPABYBdNubVFLLJ6VCMK/o1gauB+2HRFMac/T6++zHNpusRDvrbJTfNdmC9Vwx5EUTyDqgaGgeX+u2LA04KLNeiTSBpczhtXuUXoS7BcwAP2FbEfO330rfnqTtlSjfo1C0B2kpHePlM4RPIhXbyDpZESx3aQ7TtxnDYrPC1oV9XjePfwy7czJ7AC1SJ1d2+FJofwAxR+qjRqkgs1za1qnpuB1jsNrUAEhNYj8A4leoZk2qC+QYNkm+Y4dgzr+0kLNhmlP8h6ZUCtWOC5Ye/TiLjLvHPFHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TBXux+vfNu8lB2J8jUo4zySR8xp93q4gxe9klevPM4=;
 b=mGR4I3WZZwBmehCx0B/OkfGiIXpk/S8yN5VUanw0l+Dn7LvVLHMuuRbXJU7uZ7jadiZE6XTSDb62kb+Py5OeZ/crlqtelM+ELYw+s50CTqUN4sSIrGace1+y4JFX7XIPrTrfTp6MNcojs2bHPPFe8aQdc5CXxTvULG3AB+iAQqD2CH9k7QWtZuTqgVyzQPhxLnjXKA4fy3SOCSSUoQjARy1gFEYw6Cnf0nvHAeyHnJzgQjPXrsJ/OH9pzOSokj1TagaM1jhKa4EnBB8n7n6KX14u4LaKNQqtxLK+VKOTgMKqm1/vrgfG5jBJK17snQIybVglAj2eGHtr9rUszjlFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TBXux+vfNu8lB2J8jUo4zySR8xp93q4gxe9klevPM4=;
 b=DEdPAs6BLeF2Z96DpNM+Wiqnf8NkFqbUeLyC4ODt3q5oAXROcJwRmC/h5O8BablAm1jd0CZhSMZ5tfvKPjtg+S+q2m7yJb8MfUepDSVKXhOqqPozqwePyeVLEQ5+i103BKGSB0BmZcoN3034VdoXqZ/z5LmhEGPNXwGI79lA2qA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA0PR21MB1899.namprd21.prod.outlook.com (2603:10b6:806:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Mon, 24 Oct
 2022 17:10:32 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%6]) with mapi id 15.20.5791.005; Mon, 24 Oct 2022
 17:10:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: fix repeated words in comments
Thread-Topic: [PATCH] Drivers: hv: fix repeated words in comments
Thread-Index: AQHY473N6IlnEgEpIkCJSb7y3TNPWq4dz2Hg
Date:   Mon, 24 Oct 2022 17:10:31 +0000
Message-ID: <BYAPR21MB168811F3B497B61177324F94D72E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221019125604.52999-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20221019125604.52999-1-yuanjilin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7bdf176a-ff17-45ea-b066-2f9bc84fed34;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-24T17:09:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA0PR21MB1899:EE_
x-ms-office365-filtering-correlation-id: 6773fa9d-5221-4366-cb25-08dab5e2a857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2VTckBKcsSd+07InMhibwI60VDp77FpxZohWg0KY3Z0CFbMWS5pIb/j3yY+9VYMTL6m/XZTsIlpiH5SXWwER8+x/X/trMXJd/1ji4TAo+bdqO7cUj+E8LH7+8Gdlw4EZFSdE4fatmsxkxl1A0fp8BrOrN6My/FoJEcrhj284rGaRdLhx7grTZIi26ufyC8Ju4tl3ePAklc3Q3PE/Zu9Rqo2QjS1Jx67bEKrvWthMsYdWk4iKQtr6qkWgT/cdIQet5tLqLfqCoFpUyvQ0yrT/LJPmFhORLtODaZdfHZshrBd5SMkEn6gM0+eA9NeCmYAEnAp6lyGjdbMdOV5Vd35W2D9TQUzoJAUymVV/yhWfwsdAnHhBrepPC0Dj5vRgtPUiG+GPj3D71Zwbr6/XA7TiBw0AhBM5Z+uFcY3GDjuABKdsgIvS0w2fMkNbiA4mXiw1I9maQ5KIGDgIRXaA5LtOUHwZW/oX92FAg/4tEnWfSLO5Zs5QoqDfnYPAkkooMkU6ip0Q5DRSL+SRhHy2lj4dkgF8+TpQc15Edsebc8EcqpFwpTTigsMN/zyFRArIe74BBpI7AZreLbhxuC4KtpPxO+ilbsJM6PTmJnCe/yiiJq3cKAR0uIna3oTx5e906r4VKVIUE+d/AE0/eU8mtn9bbIFVW86kI3VDj0AKh5mk4o9ZQ+ZF6aY74sakWwNhO6IwT3G9My+fByVF89xGjk6EuGNqdxHzaDx4XjxODYbooBMBBhIM8aVkhnF51FfoXKHiTiwX08DqtlohTyKUtuphSLVJyxiVGPwf8Uv0mbYbcXLQ1UPaEA8grfibxBS2DmY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(71200400001)(5660300002)(478600001)(8936002)(52536014)(4744005)(110136005)(2906002)(6636002)(54906003)(41300700001)(316002)(33656002)(55016003)(10290500003)(4326008)(8676002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(38070700005)(83380400001)(38100700002)(122000001)(82960400001)(82950400001)(6506007)(7696005)(26005)(86362001)(9686003)(186003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vXM5Vkolv63BCPW9gCLQWSHf7aLEdxU0zDxfLvzbdYPf+L+a4cwQhV4cqf2?=
 =?us-ascii?Q?jtQDVeuDz/ZyFeagol7ora4lHeFZ5pwB/Exj7NF07GrYJQN3pWSknfbqkFO5?=
 =?us-ascii?Q?TeAKpU4TsMW8HpApyLY/qqAMyXoGPLqet95fpv8S4HnJNco7O4pHUBXRumyQ?=
 =?us-ascii?Q?yyN7ljpOMeu9c0OAfABqKgMPpwUqCkfQsVDmJDDfbrfFW0rPBZtZHCdXDQKt?=
 =?us-ascii?Q?ZPZRPW3S6zqA2z86iG/TJR6nOnI95IhTlPQo3AhVGv4ZxGfDNK7+lWPgPSX4?=
 =?us-ascii?Q?djRV0PHyxiImNOs+PohflPZ19AbpTM8ThOZikdwSbXdlfrn91xEaplmSFd/P?=
 =?us-ascii?Q?qmcYultK+8N+twrQtcSdHeRwhMjPfo92weq61RHr1d7qz1FsXl6+y6rd5Saj?=
 =?us-ascii?Q?ZJiJQrgtlH9N2wGL3qj6/2WO8rCd7SNzb2HVFM/ULB2HEn5uITfNDQEgBkZ2?=
 =?us-ascii?Q?doc2+lRHEaxkedzOA/1Am26ecUryVbAXLJaetPPklpEwUdw2J/+w7wklwDqN?=
 =?us-ascii?Q?OP6cTcG88m8qRvl8po+ToiV9FkADmtPMCRv4yf1f7NDzgdILUoRC3vOHem0x?=
 =?us-ascii?Q?WNEzmMqvwMXHXFgHH/REYeAj4fnB5ftvBXIk8l2peYXOtD3ZQFgokqmnrb5E?=
 =?us-ascii?Q?8E1tvSB22P1j2r6t299tCSfj7J3AmFLHMR06SnExrqxl8rB97FNQa2Q3sW4e?=
 =?us-ascii?Q?P7ngrvxSyBfif9ANhmoz4IIqyxIzhu3ZQ4aj8xUsrSdLJcX6umsiXe9EbfgR?=
 =?us-ascii?Q?3umRV/uiP1D0KMhKzvH6USkLoM8xiHIZbzR7kqosHTcX8ByIIeeW720FVk+x?=
 =?us-ascii?Q?zR7Bd+0U1TZUlqt2ncsGb6aNYExJ3d6xbVxzRfKYMs3RaIgPrWy4xNJ65EFx?=
 =?us-ascii?Q?PbAkt7mN363TW4HXzd+v8Ymx7v1O3hFwJYpAmecqhpLl6xPbnj9IdrO4Bc3a?=
 =?us-ascii?Q?bI8Sh8dhxwiov+dQdKuK8zKobHKu8EcKxEVXs/hwEdb8sspXTyf2i8e6t0h9?=
 =?us-ascii?Q?IJ8RJwKixNV2Z6pEg0ZI3+7BT47yztxK51JijsQmkxNzXd0SmktlsXp2PFQm?=
 =?us-ascii?Q?oidmNlb3kfnOs8SVHf7shFNirCOqaXMmIypq7Z3ZiK4V4bjrMm04o1Pf5Xok?=
 =?us-ascii?Q?HBecIQ0qQpoe8wDx/DREzEtaQHACHjV0ASIaQEo1c5WCyxw/4WSGLrx13GHC?=
 =?us-ascii?Q?bLMbcn38rdepUgIF4/qLdizK5UTU/cYzQoNXq69NN2rL+CZK39eEzKFlyddZ?=
 =?us-ascii?Q?kl9AH8B2iYuIFTZMGFl8l+TleWFuIIcd7FPvzqWAh0FvLMHpat/0XrZXLLbh?=
 =?us-ascii?Q?HISa3YJORaB4tjf+nElib6R5eMMqPKkTJEN3ZAqW0xKjhDRjrAi711DQ+bWl?=
 =?us-ascii?Q?5deYoCjZX2KX8ugtSkFeDEfAclGaJjm0diIwUZc7im/jo3YyYJQgf+c8Vzrd?=
 =?us-ascii?Q?UIECTgWsmGp3s+Fn6IBqCxPxseEVfd7WzmENVrfRt6auE33Q2jJ/0YGfsw2J?=
 =?us-ascii?Q?/3v1DNL0aaL9Xk+OtayZ8RAAX11wF6Zb6zXQ4CP6MH23mThS6qe3i3Oi413h?=
 =?us-ascii?Q?UfVvVYh6yiod27TkR1zNzHYtylmckZA89t9KJlhzB20ix0qYgZtEEh1eE0qi?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6773fa9d-5221-4366-cb25-08dab5e2a857
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:10:31.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1KNGgBVATbemNIX21wNk4/Xyp3kMVgNsC0lSxotv/VehaEC/idQFA1Ldgvnue3f2DLtvZVlKylE9SHhPSDmc2Sl49gpyQZyUsLuU78j2r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1899
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jilin Yuan <yuanjilin@cdjrlc.com> Sent: Wednesday, October 19, 2022 5=
:56 AM
>=20
> Delete the redundant word 'of'.
>=20
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index fdf6decacf06..6c127f061f06 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -905,7 +905,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  			 * We have some residual hot add range
>  			 * that needs to be hot added; hot add
>  			 * it now. Hot add a multiple of
> -			 * of HA_CHUNK that fully covers the pages
> +			 * HA_CHUNK that fully covers the pages
>  			 * we have.
>  			 */
>  			size =3D (has->end_pfn - has->ha_end_pfn);
> --
> 2.36.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

