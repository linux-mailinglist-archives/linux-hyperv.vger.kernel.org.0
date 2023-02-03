Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC59688E46
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Feb 2023 04:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBCD4N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Feb 2023 22:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjBCD4M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Feb 2023 22:56:12 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C52D15F;
        Thu,  2 Feb 2023 19:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/4h7W+Yp1HP1VHgxDq/4l4rUWYHd8Q+JzmYiuP1fSRWxBIFmMAZEqwcccQ/s6q6bkUSfvyjtkQISa1qPrBhmW8t6drViErBUns/laoP39WfAvd+7MNsjttD2TV+fVkQgFQ2m565sC0ZHJ3o2ndY/cPizLtzsai04kOqAwIBteRlsnMFB3ej1uPw0OdG5GXeizCoSDHZ5FIq9adqnVKDw9p4RoV8v286KN3rFbc6ka40PCkf0yEMkQ4sV3DWjepXmiot6zBS8ThsdvNmH6YunEk8VEI/dlsAkheN4bVoJyoXJdqwnwX0mNi+lwyjPkBWlnJGm6M0vcQ0Gjj5xxeeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bto/D0odlwW0ihNJBV4oXEmQg3xpUlLLdZuoE9mghhk=;
 b=UFZRyNmS87o6XUddncQNuGHcFJhsDLKoOSg7QyF6OL197bSrFO2SHEE8WjtgMnQ03WMOUPnFYOiAQS01p6JRMyx7WKJMDQ5GUft3mL/xstQSPI1tuO6eMh84gXq6iCchzq+fyfDFAnXycTiUbTraFXiXDhlxbAGgPquudydqt9FnfLvD6+yG43JxPjh9eiYZHvCmF4OmWg3PX3LeMsEXBW9eLzxM9Ze+DYv4i2WOuXm9eOju3yjmlZP/9A3pM1Ou3HcFSitdIedctVw8bJ3qNcosVx1/J5E9EBXLJz4sRubzmnsJHIRQkQWYbgZspu5FTZp6cFFI2cRBZUtrRIt5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bto/D0odlwW0ihNJBV4oXEmQg3xpUlLLdZuoE9mghhk=;
 b=c5JdPP6C04YLD1bj3yjgRpjyFEFLGm56Wj7PhRay1KU9B/dys4uo3Dtx3lBXxWrzMxbSK1xvI/lpp2EIFcb5dy4WRROD7w4Rs0KI4Qjg0YKw4jcCtfCmChGN92ts27qsFg8JdN46lnlS1iyh6DZjAfV/07KfdiT+bPnkeLTt+lk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH2PR21MB1526.namprd21.prod.outlook.com (2603:10b6:610:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Fri, 3 Feb
 2023 03:56:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%7]) with mapi id 15.20.6086.009; Fri, 3 Feb 2023
 03:56:06 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HV: hv_balloon: fix memory leak with using
 debugfs_lookup()
Thread-Topic: [PATCH] HV: hv_balloon: fix memory leak with using
 debugfs_lookup()
Thread-Index: AQHZNw/41mM1aBQkTUSPo77XIJemYq68luYg
Date:   Fri, 3 Feb 2023 03:56:06 +0000
Message-ID: <BYAPR21MB168826E0AF83D40DE0C704F9D7D79@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230202140918.2289522-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230202140918.2289522-1-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0470cfcf-ef8a-4b5b-b921-e4ba42e4d0b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-03T03:49:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH2PR21MB1526:EE_
x-ms-office365-filtering-correlation-id: a8ec8129-61f4-4a22-58f1-08db059a93a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mDBJGPzXNc4EOpoVgxA/lheTT9THYFtjTE3NA6F+xNC6wd/AcnG+Wubk768LsjOzeQtlnYl8HEe13UI2PA3wvDXhHDo5Wh6o2OHg89D6tt6Ez4c3m+MXPR9+mtUmjowvTQg+MU/R6xf3vlBAA50+BsQ9YgwoCadH//rfVooGrcFrygsC8X58XfaNQCxgrzhGH4/pyhe011jicyhxEX5qyWV+/e+9Y2gqqO+YixGSxWRTzekoO40dTMgsQXYA0iVq+usQ1Aek4GM36Ouo1Loe3DYrI2Nh2ecVT2RK6ICiqU12C3sMFaQywnoLXcHI7ToTY/69yeZfpDctv2hy+ItL/+U1rZaZ06sTNssGSr9CtmPDwVyjVDGSitxS2GxoMlh6u/rETWwNry31jIMmWyjT96Njzom/j2HtzDAI+/3X0wEKkK/YysWypTwwiP3B04GHHr+9a2m3ToWPqXejZGLV6Q89Ka1HL9UHiP2id+CVcawaCXmjhiFNwPHonJB1mANNo29u9rhrOacv2KTl5XiVUjGwz2xaxrhdsr5sx2XOu6/ZgBTe+Xz5pb5oaQqhDo1/32HJT1GklO3LYEzfUC4EUhfitxcmLDkQCacmGiy/HrTxbV1H5HJj2w0NYbMOotQd3Y4UVBfq9h4zPTzc4+Q6kqoCbeSMfroYNtDqYPyh4FZi4AbqGCR8lYBT8ggvPT5iLTvNyTy7y3yoWHKkyxF7HuMTElZiVss7YvwjUFGCNLpKd0iGmbMaps9pfe6mWMH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(2906002)(33656002)(8990500004)(316002)(110136005)(54906003)(83380400001)(9686003)(186003)(26005)(71200400001)(76116006)(8676002)(66946007)(66446008)(66556008)(478600001)(66476007)(64756008)(4326008)(5660300002)(38070700005)(86362001)(8936002)(52536014)(41300700001)(10290500003)(82960400001)(38100700002)(82950400001)(122000001)(55016003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OX7EnY0CBDLJx2fUSh/k9+8ZyB6x03e6IcSGoDe2FBovjiSEYbAUD4nQgZFC?=
 =?us-ascii?Q?illbFla/LxOkZWu38rOKrZdQ7snwAxymkUUqJtRORKZrdpqsUOGD4hA2Yy1A?=
 =?us-ascii?Q?0Ivqc5z5hZW//M6KxxsXcia2joy2C39/Z5dCFv1Nbl+qgeZC/Gs3/DD1znzB?=
 =?us-ascii?Q?N1Wbr4sdd5wRh4d7gPVUNnZG5VjPe4anAxpwsok2h7+ZoEen3CgRCAiDDNYx?=
 =?us-ascii?Q?bPGAeKE1KryAgAOAOK77lXnFBbNeOGTQlWVxxSCpYTmS2TedKCP5/xUuobcr?=
 =?us-ascii?Q?eeUPqgXyLtXYkXTrd8Q4BH6ho+LP0aSd2i2av6GOdc+KxaMTdbgJmH9alWSE?=
 =?us-ascii?Q?9w6mjoe40zjVW0RjFGexkEMY1pO80m735h3BD4QuI0QVupyQRXhi4iffDycg?=
 =?us-ascii?Q?GAxAgQv5cRT0ti3x7yyKqZ/cHeQre9h/rsvtbHy0y5q0UHJY7CMEQ1dm+AxE?=
 =?us-ascii?Q?ZmiQHAHR8NFViva7lSLvom/wJjKbV2ZX+N7KZ/r5IybEc86Ynohfxx+MOA4/?=
 =?us-ascii?Q?N3Yu2OLQjfLkSBmWO19UYvL6r6t9GtU2LYPRHdlHACJ2f0y68zT0FjpIwMEN?=
 =?us-ascii?Q?tcmcWYl2QbmE6wJKtJW0LruXZq/ElWTzsfdhvhhEoAWBpjPwB7tnXgOXwUI8?=
 =?us-ascii?Q?X1CWPc0v2A0nL2kTcBRVZ2F5zFVoRYk3lH8pHzGhJzQI2DrVzFT1klF0RyQ4?=
 =?us-ascii?Q?oo799FvzMPIm5Cfk/S/SurlrSoAGH8twsHTXQoWELYQJEzfo0gmsVR40BPeK?=
 =?us-ascii?Q?1h+EzwOF9BbCvG5upyHaO8/9MLKIMl89KrCL9Hjzf0KPPQcarc5S1UhMqQMP?=
 =?us-ascii?Q?yV2hncpSFXSNgmVHI3/+jVGOX35wwK0zHwVP8Ss8pbVxuiddYBcgIarIbL2T?=
 =?us-ascii?Q?aw9K+fqkyPmw9M1NPhiEi1Sc1N9Gekjnl+9ojvB6t+LEvpfc9kPGn8j+1aK6?=
 =?us-ascii?Q?mjXFnFiWM3Qu4dsobZD3nq2yWmRUIOuLiDFp3NPZgZacyeKoWSolWzyPdjR/?=
 =?us-ascii?Q?veqIk0ty4AGupe5ZtnV2p00D/HZtPAj04MPHp+RZRnRT2jgN8ZfKVCDkJGDr?=
 =?us-ascii?Q?yaxGfvpkVB5vpN6x5U6pq3Qratd6mBLPAkwH6LSmVHDf+sdNtTk6K/jRMbwM?=
 =?us-ascii?Q?nKNQ83/MB9Yamzia+Gxk97D1JjQCxAQwxrZHSGkZeWvlPgK4qfU4scGyuvHH?=
 =?us-ascii?Q?EKYRNVYyZpkzmYMQzyxNBGdEBwbeoN7SdJ0RhEFEy0smDyXd4VyfvIwqbAdk?=
 =?us-ascii?Q?XiUXFmSeoumWXLmjyM7vsbKrRrr18s9X8FX/MuTDyw5qLO8hrRjzCSqkbqGi?=
 =?us-ascii?Q?eR0l585ahL+9vb4cX1ED0W6oCt+zV5nw0uPnoNbdacAk1NK7Pg7okiFG3nWY?=
 =?us-ascii?Q?+jffWe+7+mGLVo8PF1x68MLkdacsso3as7gKXffelKchZXf5Go/6BRq5Vcdn?=
 =?us-ascii?Q?wMnX2S1lmPeR6Kk7JD7AIeM6fPdzT1H2E/ghkW76cW7rgQulY8Lh2abmM7tg?=
 =?us-ascii?Q?QwWs3O/cQ16khHo80l6gmIFOw/YvFUhrv30qEH1SyipVl++TQ/Dq8BUpx/rA?=
 =?us-ascii?Q?Tz6TtG8koNoTDG9WzpyjOKPneO1aiGV5oarkVUiGXAutqpf7PfKTb5tIuJVK?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ec8129-61f4-4a22-58f1-08db059a93a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 03:56:06.2712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/XPT6ny4XGHxQ2CldQp1/4voSsfgIo8Ie1KncN+kd5iKzfZ76BO7J8hlY3FfuRElp9E1Fz+ttgpN/mr8FPYoaYXoCCRJNxwu4AexOGzqiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursday, Febru=
ary 2, 2023 6:09 AM

>=20
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Add a Fixes: tag?  This hv_balloon debugfs code was added in v6.0,
And I see that debugfs_lookup_and_remove() was also added in v6.0.

Fixes: d180e0a1be6c ("Drivers: hv: Create debugfs file with hyper-v balloon=
 usage information")

> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index cbe43e2567a7..64ac5bdee3a6 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1963,7 +1963,7 @@ static void  hv_balloon_debugfs_init(struct hv_dynm=
em_device *b)
>=20
>  static void  hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
>  {
> -	debugfs_remove(debugfs_lookup("hv-balloon", NULL));
> +	debugfs_lookup_and_remove("hv-balloon", NULL);
>  }
>=20
>  #else

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
