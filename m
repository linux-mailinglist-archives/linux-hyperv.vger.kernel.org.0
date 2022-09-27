Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8935ECF45
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Sep 2022 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiI0V0n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Sep 2022 17:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiI0V0i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Sep 2022 17:26:38 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2EE1E76BA;
        Tue, 27 Sep 2022 14:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6qyzvcAY3nGeYYa7nMmECeJzebHuhZGBnB7MWeKDTIZjrhkZOOTx/k+av+F9ZcmI98xKjsnq+1PtE/SQtu8mRMk5vCAaK7bEKuqVSXm8vHx07h62HBCr3Y51xWWq/YIAIb42yU3fZ75uZP27KegUse1SPYUKHkNfVRbPnylpB14m6LGVV5KVvzkvh42sBYzHqQUxzntFWHjn0gL4fucajkgZAeAKHzvFofI2tuxib9DjK1yeBKiAuxARMbpz5qy9zul2+Un5pq8nH3MHg/EkFFQi9T2M2ZtwORr7hBXrwZ+0Ey7KfH2GoVXW1T1ANhtzYz9Xpu88i4bgpwyLeRDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEo9FvcRZ/ZQpiXIiAGHV5azGcLhmbj1ltkpclJaVjM=;
 b=K6DChhpirYwR8I/YfXqyoDfoxOfeoYGzXRUt1VQ8CP+R3/RamsEs9c2sp8WcDXeGYE5COn65ju7T49K02lOKqUKi+t0UItne9K8YTg9cCb7MW0rdmv26AKdILw13kYzoxAw5CexCeTZJ9VgekyILQOpbqG5SwVgBZRGJ2NoZXrtinUn3Y49u4u5dYIRtjXzbl4fA9tydNG6aWsUrgWt8HLEXMnJNYc3u2+0IV19yZOfs3Gy+NcK52TrbfIKjTtjqIOlkUCOuwm2h6vrvqaaFgK01A0PYVnsEuFiR8WODK3XUpOvhDzP9qqVDcBlChmlBbyXDspiffTnPCkBsHgg41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEo9FvcRZ/ZQpiXIiAGHV5azGcLhmbj1ltkpclJaVjM=;
 b=W86nzcfU7MoG8Cp58idkAPzDSX50hns7iyv+1brCLDR2DUTe2YzElAmQAeEJPWShU3O5jSJ1zy78W/nKgwnB1LNPnGIZGmUAYX2vQa9ClWD+ddmcY7TLBWQjI/7/wTSGH2NY2LQ6HrQ2/1Wj0n7pHqhnJsobNisg3gFyOyfECfE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3255.namprd21.prod.outlook.com (2603:10b6:408:14f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0; Tue, 27 Sep
 2022 21:26:32 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5709.000; Tue, 27 Sep 2022
 21:26:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Kees Cook <keescook@chromium.org>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Split memcpy of flex-array
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Split memcpy of flex-array
Thread-Index: AQHY0raXcdwUcYJHY0CDOx4M83l8Ua3zyZ9A
Date:   Tue, 27 Sep 2022 21:26:32 +0000
Message-ID: <BYAPR21MB1688367EB77644B5A7A3395ED7559@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220927211736.3241175-1-keescook@chromium.org>
In-Reply-To: <20220927211736.3241175-1-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52719b5e-0f38-433c-acd1-38e08b8a8691;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-27T21:24:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3255:EE_
x-ms-office365-filtering-correlation-id: 4561310a-fe17-458a-71f0-08daa0cef2de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVcJtkz4QOqOu6VVCH32pRjWA3ay0eq2oZwDcY5J0j1g4jy/H6aQ6ok/uki84HT7tVQZYOLHcIus+lkAvpMLI2h7ImA+weAhMb8FEqTvOk98zZPfanOsXvfI9Q9cxHPnGDv89xVs8v/SdmIe071cZTTDh7OX6mh1c2laWCaoK+fhiVXNP5M7VcSeoCX+9oL1gbjTxvoU4rNt+QyK4ApAlkBsmWrnRh3x5z+UzYvBu9KTXLcvYIHNmbUQOk2R1DlFCkgtTnXV1gmv46uTEo+4rDYprI9LPewJLzLNR7IRhiHaeFQtaEzrpcaHftl8N4V4ChDq3ae+n3NQwlGKjohPbeKmBVInyQxNKPKj8+jHbQYXbeG0EBPD3r/UfSvTTS0sefjeVE4FGOutfpd/1WHOsT1+C326GT6ZN5yzk8BDwPob3XsqW+uLlgbOGj7numzo1OFjcXSsTnGFCU/SRHT4EBmMTIbqtw1do+oEv31quCxEACcW6qjOchek/uqHI8oB3CuV0XDNj3ky6864r60775kmqStavUVlS5OaK6/+S6r0rykRuOqc9rwXetMdcwxVl3PvHXNzKuoJ9Y7Y5xMnVS6Xn8ZcWqetpnauiZHqR88gFHNYjLkx+lEacMaDCu7XFqc9EWiBLo3jsAALIAN6tRBgfIVPj1B51WqWHwPvCPhlTkpd7eI6oIypO5r/nBRijeKW/c6rul6RZRtT9yN7qboFwAb9dXs3HzhKuwTVNIa5u2iq5yhC64bsbLeshFcuDgttxeDzFuvYC054TwlgYHqTVCySrUmEtil3xninmD2EPUU7WartL2z8AdwPaQa5lBLCcoQUCKXBTxjcNKhwRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(6636002)(54906003)(110136005)(10290500003)(38070700005)(82960400001)(316002)(55016003)(5660300002)(33656002)(52536014)(8936002)(66946007)(86362001)(82950400001)(66556008)(66476007)(66446008)(64756008)(8990500004)(4326008)(76116006)(8676002)(2906002)(41300700001)(26005)(9686003)(71200400001)(186003)(478600001)(6506007)(7696005)(122000001)(38100700002)(83380400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oDBY3w4y3ladGfpH9THWVsq0Nm4ROjZb17uFXOhqBNwFdkiRzfOu+naEvoZX?=
 =?us-ascii?Q?sPaho9La86e6EaqmZ1BVHCfT6CUtroojQQzW5/W6vPpmyalLzKwFtFUHnUCf?=
 =?us-ascii?Q?Q15eSuMR9/TMVvyQiesOc8tPWrjeUkPD97B8olGDUBjics8bcQ3eQO32T87b?=
 =?us-ascii?Q?0/foo3UNVzeGO5x8KsYpDZqBfsefUX+dsvyecjNBj0P7cZQVGjCpJcqUcR55?=
 =?us-ascii?Q?R5E8ON+IvY6Wc4hVwho1mLCggSgPVDaBEZs5LSCO9xJJ4Vev0tYYbW8CnuXN?=
 =?us-ascii?Q?UPBxUcH1T3bLlvbf2U6ykWTFq6P7CTs0xtNqYMVpUX0le67Uy/NFkaiapb87?=
 =?us-ascii?Q?TjpUJy7FBVjF1YrwxSzbFYmBh0OxpAC1UWqvYDsp/IK4tB8QSqzyIlPa0P9v?=
 =?us-ascii?Q?U5ysgRn8a/ZOp0EfaH98QcPyh/mhobmXEFEVuGX+z88NMHBsRUqBWwjHGLnL?=
 =?us-ascii?Q?qajt1prswpB0Afb2NXK1dZ90+pjxxMZCZzD7Uxy8/QryBRKwq96L2lXkng97?=
 =?us-ascii?Q?cy4rAdz2iGOdeltes8YZL1gDCauB8+Dw/gpfaVu4I6q29FYZOMZ4lIwg/ksY?=
 =?us-ascii?Q?3Q2NsFzs8C2Il66oLGQVQROqkMwCTr1owOJKA2JyIlNPb917De2MSLRHz5ZD?=
 =?us-ascii?Q?1BQhshvmhiJ2+KAuXg1LxWKx2nI+v7Pu3CjoMX9VQ5W9tk3yFP2mMZ+S0P7X?=
 =?us-ascii?Q?Gq5sSkKT3MUCBl2jXyqhglSG3iO20SanxQOzSHm00CwdnK2ngEJgWHrl6zJG?=
 =?us-ascii?Q?rFYmX9t/jCcyFajjVQVpfLB2aKWzzRAYy/XgKGVfp3S9m8vLI1yyvbsuojhP?=
 =?us-ascii?Q?FqQDWfdZTvoa/xxr/s6QIhzCyCzWY67tcZMqy2CtLYW0tijDw2XsXqNZgxUl?=
 =?us-ascii?Q?yFdR/E0mMaMKtgg9IOUp7c1p8guUz9T/PnlDw6a3kjW6+Pn9GxS6H9rQA4i2?=
 =?us-ascii?Q?UFsz07m+B4zWlMlzdkaSW+fwqLbjOorjrCEPoqD72UDkJm2CKaeV74yKn8Ae?=
 =?us-ascii?Q?QMzhLsFr+GwAq6ZuMRZEPBzWxKMJ9413zvLbTEM45KdI8u+f90TGnf7tDu+n?=
 =?us-ascii?Q?mQYSldYamuMUX5bs1z5AVDhRKpD099YubFsRaGJF2KwJeQvCqUAddzY4AfnG?=
 =?us-ascii?Q?ZxfR4Z5S6zWbR5lvI/DEf+iEkyzdsFPfLJ3Vy27s8UuOjXEf3aZOAG/I0PBF?=
 =?us-ascii?Q?Aur+AQH61N5V+X9c195osJGU9kFnWumOY8WX66naXz++3obqwSdSd0nH6QA1?=
 =?us-ascii?Q?/AD2hTj7GloRC9H7IXElqCpjcoRFsT7dXMn0s0dYKSe1SWwYMb90qTCo41mg?=
 =?us-ascii?Q?7VT7bdKRs6fQWRz+OHAotTTgruvc4pMKoPfu2azpwcz3u0F6djElO8sXxDEp?=
 =?us-ascii?Q?FFI2E4bu1NIMSdUzHgr9hGv53urXEnlUMWgXTKCi/wuZwdlwDPwpa2WyEt7u?=
 =?us-ascii?Q?YC7Q2F0GH7YJQXc9pjLJm52J4oliG9+v4pMX4QYt1itXz98XgVw1LnsK6yM5?=
 =?us-ascii?Q?I/PZW1cAk7DUbupsbp/TlEcF2HCUx3xQtqjsx1a8XCBNkMn7AqhBXsSJa7Z9?=
 =?us-ascii?Q?HJFFsJblF+1TdjzOGGaQQGOg38hSihQpZSmbUjBZRErS5rWe/2MuthbqG6sR?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4561310a-fe17-458a-71f0-08daa0cef2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 21:26:32.4236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wf9+wM3UxULjgysxVhGLl/qPOawb0RS8nuFykpSwv/abPj5fjItw3zeccV5EYRrSByWWq5whOfL6fv5jU9dE5a4r7WZEKraxpziPgnANlVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3255
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kees Cook <keescook@chromium.org> Sent: Tuesday, September 27, 2022 2=
:18 PM
>=20
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated. This
> results in the already inlined memcpy getting unrolled a little more,
> which very slightly increases text size:
>=20
> $ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
>    text    data     bss     dec     hex filename
>   22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
>   23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o
>=20
> Avoids the run-time false-positive warning:
>=20
>   memcpy: detected field-spanning write (size 212) of single field "&ctx-=
>msg" at
> drivers/hv/vmbus_drv.c:1133 (size 16)
>=20
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-kees=
cook@chromium.org/
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: - fix commit log, add tags and exact warning test from Nathan
> v1: https://lore.kernel.org/lkml/20220924030741.3345349-1-keescook@chromi=
um.org/
> ---
>  drivers/hv/vmbus_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 23c680d1a0f5..9b111a8262e3 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1131,7 +1131,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			return;
>=20
>  		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> -		memcpy(&ctx->msg, &msg_copy, sizeof(msg->header) + payload_size);
> +		ctx->msg.header =3D msg_copy.header;
> +		memcpy(&ctx->msg.payload, msg_copy.u.payload, payload_size);
>=20
>  		/*
>  		 * The host can generate a rescind message while we
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

