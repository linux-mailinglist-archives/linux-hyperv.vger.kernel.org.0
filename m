Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3A541F27
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 00:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380401AbiFGWms (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jun 2022 18:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386038AbiFGWmV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jun 2022 18:42:21 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E94A1146B2;
        Tue,  7 Jun 2022 12:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRebpKmhy54+DPZNwtMPX/RatYCLgR/Y65SmUqSJ5UJ5sJ0vUcuM20aqHHtGbRaIIFDpXMWxhcelrO8/Q7TG/Dtu40iI3WeJykNXGgQw3ZKO5ZfuL5EwujAi6FdvKGM4ESj3Wo2skwkvQ29RgE2oy25oQa4hVsqs9Q5X4j4ZycFkLDQlHzDQmUfwrENTzCl6087RNDiwxJcSm6hnBFzMmPndNw7wQ2tRWvIQdMGlDtZbHsbFIk/6yI5Xk77a57kS4Irlo+b42e0JQd1rvV9u6otfxpj5k30Xow2zL7VzNklBvxM6jnRu6j2f3d/4hgWQl/qFELwwgABhtNaBd5wTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT+UgAS+yR+koyvwFZpzcQA7n4aEQWI1fIt43VpQfB0=;
 b=gXyy6V3D51ptGF92fieGErs6WvuKbVPSh1rb5KIRKeVsL9Guww6C8sdK8XnKf/+nPkxpaKrJMBqi+LYlzVywRMrh1jAYMPDj4P+Uw5a1H/F2zgr2QA5Jlzd3Pir+MhEssusz0H2l3ZA5mociKNIzgJ8PBtL13ykz2TXMKsxVlR4gu3aG3O4hJJiw16CMN18+VThk/+rJ0aylMv2qcmLX4PkQR4Wf04AQORr3lJ/IGNKKQQ3XmUcwhg3AVolMsrgRpF8Yp/tCZjrw6jFJzwV9iADOFz848npf5cWAbIhsjlIXIEcFIjXD6uO91WzWPGZcS8QwCZRbCRg1eAjdXQcQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT+UgAS+yR+koyvwFZpzcQA7n4aEQWI1fIt43VpQfB0=;
 b=jSUBpZumt5F9eip4oURVDiKXx2R1wtG3SQqewnqhKqTs7lWFQaQD5Lcuy91gYUOUl0eIa0HyQ66xPn59tJxgOmGF2afti5Tj/2n/jHoCFcU/8FPJLgnBrJ2cBMW1alflJNEXys+SSk0W9Q5h6QUJICURq6azux5EHWkNQCDYDLs=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3092.namprd21.prod.outlook.com (2603:10b6:510:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Tue, 7 Jun
 2022 19:33:52 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.007; Tue, 7 Jun 2022
 19:33:52 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Fix syntax errors in comments
Thread-Topic: [PATCH] Drivers: hv: Fix syntax errors in comments
Thread-Index: AQHYeLoQTeBNQUjmr0GlFeIH5YYVQq1EWSKA
Date:   Tue, 7 Jun 2022 19:33:51 +0000
Message-ID: <PH0PR21MB3025110BE6D81EF2F854B5E2D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220605085524.11289-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220605085524.11289-1-wangxiang@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fbc5269c-a63c-463c-8ca2-67beaa54451d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-07T19:32:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fcae57-c3ef-442d-71a8-08da48bca6fd
x-ms-traffictypediagnostic: PH7PR21MB3092:EE_
x-microsoft-antispam-prvs: <PH7PR21MB309297F56DF44F4C995836AED7A59@PH7PR21MB3092.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gh8LcQXVjkkDYCKalzJ5XeVhsuCEiAYypxWRhCvcS8LjjCfS4nO6VPykej8TRAL/pQwUz7Pi6HzPKpOWQriCIEG7cwjCtub1hlB4LU2Oq9/vTOiCY2JxRckuFqJL9xl9uWu8rowQHgVnPUv6dnHvoAVMGBjf6+QazzYuLjGMGgKdHN3WYHDQDWiXdzFwF2dJ14KnlmKGQEKCVWp3f0nmf3fPmmeUA7sDWb1+tDJXbJElfMXK1RbIMkIdYgLT7ezSRU7DO1cmp++d1TyOkilnFliwM3WIV5d1TAx+Wh+8He1zj++/YKDZ3sGeXX0t6wmWudbjmB922D6ob7vs4x/7KuKS04a7QZSzvDTKRbNZ/APcyaPYE7wXAd5pRckgpwgMoDC+Rbu7CV2O1JZL3Z8ocyxg/WngrchSBRUwV0dwSxJ88XOokve5dxOtFbpcAQHcfmkKr6BuERbfsPBb4hbxVhCvwoNBglfEKVgeOEkUH+3dp+DVw4YtFyZi8v301BxetGvPZLXo93bGWesHoJrnGMwXmv0TcE8ExvupDmmahs4Clx2mWrTgbF7gl9Aas6lY8NZsi6DbuSABjAVZtsyuCRThTZBFr+E5FoGCoAmRVtRIXnnk3GoShrr36CiTCh0ZiYHWVeKFy6aBzFaOeHmLOxS7pBnZ7oPJo/Fy6Nv34aw0eWl1AKp7hNQWyedP18qlvcA6Sfb4KLv3mMmboRRpyv9jxR06LeO/lt7zk4fIHFpf956Fk/QUKIz4ShWCgDPJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(55016003)(26005)(86362001)(9686003)(83380400001)(71200400001)(64756008)(66556008)(66446008)(76116006)(66476007)(8676002)(66946007)(10290500003)(38070700005)(4326008)(110136005)(54906003)(6636002)(316002)(6506007)(52536014)(5660300002)(508600001)(82950400001)(82960400001)(33656002)(2906002)(7696005)(186003)(38100700002)(8936002)(122000001)(4744005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yg1HBi2ZzT67kXxrk7BMTvJuqKGON86+G56nBN0+zODeu6l1bZ+05VGSMRH?=
 =?us-ascii?Q?4AFUhM38c98IVtxToOTw5oxANfeYlvPcfh0qVEbxne8Df+bSyhAYsmggN4ER?=
 =?us-ascii?Q?No+/ynx8FcEl1jG86qco2vTa8Mj+H5JY6i3dhJMwVX+vrW7iycp7NA/cu67m?=
 =?us-ascii?Q?bhEz4q1b80Tyus233sM//cE2moMdwva+FPbSeNUde7IQNqgfSqaaidGvFZPN?=
 =?us-ascii?Q?iA1FMx6phfeGXP2QN8egUjI0Zody2BZXiSoaCu+aAiMQVSK/PX/rbxoMOijp?=
 =?us-ascii?Q?EVvzcw7OSrOeTLaiEeh+D7qT/NntCTvYqmKBCitrktFxxnVAECdzo2FB5sIG?=
 =?us-ascii?Q?laSLCLI5LBLf9Nj1nroc+J9ODeaim9+hJscDu6XEj7S8Ha4r9ogIRz9ExIvB?=
 =?us-ascii?Q?ZCz5pkrXEpHM1pECQwzyqA5WB9iFhEy5gA3ySsg3dFbJjsGM8mUzVRzzQpQa?=
 =?us-ascii?Q?CFF3C25m6bC9AxDl81+a5T7GXbirEDEbdZZAM/OVeNLEY0iRDnFJew82aAt8?=
 =?us-ascii?Q?tMljwhS63apmCunygN0Ofdb79yifNAqQzC5YMZ6qc21HbC3t1Wl+dHDGxETe?=
 =?us-ascii?Q?spLTwsak4GC9psEIeTPszJ416yvWEpE0hpTSnqwxFZgxQeCJKvZK1Fv1KtY9?=
 =?us-ascii?Q?xkR7spLNR3ioIk+f0sLuUz7LdpC7gUwXaG/48UmbIrN65bWPygIvb/BKHegt?=
 =?us-ascii?Q?pJMQGiBtouCw7N8CW6slpH2VK/sIS2oz1MemHLFeYRLCPmmxcgrmRoM27ldG?=
 =?us-ascii?Q?7eZYjmPFig96vWF4LprcAQ8tVPXlNYAdbWv3I4Mh8eeKGQaVuzQtc2lR/qW8?=
 =?us-ascii?Q?uj6B9QgrIoSoFuohh4KR6q4Yo3+4xGCOLcM20mUEb5EjwYTesYL916p99XSQ?=
 =?us-ascii?Q?70I8KNkgAtgNMDva2AzbZ/Gl6ACm2dY6YcPvj4Yi07/PsXoWTZfoNbROI9Rr?=
 =?us-ascii?Q?HTHAMSJYZNYadsmcWpvXrNCWlLUj7ji5AlImbhKxpZ4Utg+7/moBy7Rb24Ro?=
 =?us-ascii?Q?d6GRf969Tsh5IWunSI89L+9efPdXRdW/ExGUBZpVfxlXwxyidr86hlYNPr9I?=
 =?us-ascii?Q?pFyfeTF96g1g/f4Es/a6y6t60ui12Svc5gbMZApbgG6fanr7KafFfQ65cejg?=
 =?us-ascii?Q?hsOUQ0uf6W14oBD8qv1EHrnfc7brmF84YLuhHzWGmxYuPDNPcT/5EheMkOEu?=
 =?us-ascii?Q?9f5l2iHngCbbIyKIqUxHOGiU8Ni0/+QB+a23UycsFhJ9yI/Xtv3PTBUUXJ7b?=
 =?us-ascii?Q?8jHfYqHXjHz55K2d172wndPRNQtemz+MpZAJ415Mf8JILxfHQBE6bXnG6NFp?=
 =?us-ascii?Q?M39+0elXPyHVz71dqds7Y5DbG+jdVadqAuSZlI/zxMEQkZceZ1p6Q4/fiIX9?=
 =?us-ascii?Q?QPsG1oYEoF1BLQ6uwqJSgTTFzyACeJxFqktYGLZD66gCbQO5pC+1FfVXppkr?=
 =?us-ascii?Q?VWk2UHXgTscM/777SGfJgwz7WKY7uY/R5i9rSDuTgpEHmNoU/7yynRBThk2W?=
 =?us-ascii?Q?p0URj2BBNKbJ3Yuk7ySKUavcgl4/fvj+Y0EGg3FX+p9VuuRPrayJQmSqpK17?=
 =?us-ascii?Q?246UtcjDYFk1G+FmOLWNAqL6PZbyyZqXaS4siAxELfLBTfC3/n5odfd964bB?=
 =?us-ascii?Q?taRP91UWjjdBZFhS9tcJEY2Q1xW77lKjh5v2iEG4j8t4JIljHtXtyXRa7WVa?=
 =?us-ascii?Q?VtKS+Xm95gsYZVkPQtQ8jDV/OcClU8Hk81sGxhtRQUipPf0XA+GHk3XU/Ek3?=
 =?us-ascii?Q?lHH4loaIw8eT71gkrOfBQ41whOVYUwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fcae57-c3ef-442d-71a8-08da48bca6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 19:33:51.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxTUBFCs6KW45dj5TAYl4otv9ThT0ESJ9FdxB8UUJCmzO3hEZPDtkRsmcGSZFz5SZ8fVFLU6LySWU2DM9X1liAcAzaZ8rLyHkvBABxPg3FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3092
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Xiang wangx <wangxiang@cdjrlc.com> Sent: Sunday, June 5, 2022 1:55 AM
>=20
> Delete the redundant word 'in'.
>=20
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/hv/hv_kvp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index c698592b83e4..d35b60c06114 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -394,7 +394,7 @@ kvp_send_key(struct work_struct *dummy)
>         in_msg =3D kvp_transaction.kvp_msg;
>=20
>         /*
> -        * The key/value strings sent from the host are encoded in
> +        * The key/value strings sent from the host are encoded
>          * in utf16; convert it to utf8 strings.
>          * The host assures us that the utf16 strings will not exceed
>          * the max lengths specified. We will however, reserve room
> --
> 2.36.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

