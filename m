Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7072B69B661
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Feb 2023 00:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBQXRm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 18:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBQXRl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 18:17:41 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C16A077;
        Fri, 17 Feb 2023 15:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j10hf+M/HY93X8jJBJcOgqgyGyrVrS1cWGnj83PoLDWmYTRmC5ebywfJ19KzJn0AVq4/n5C/HMB2WsGMvFFiRI6lY5Lt7Oax5dHiiRnaEXI8ghLNgfTzeOI6H8eWqQK8i8Mwh+i63mK7Fp/5Nm4YV7gForFknbe5PtVF8zCQI6o2fvOs4FebwunzMDn8jN5RSqD/VVS1LhViynisH9y+lOWCBh4WNJn8yQxi3Gd9oVRkRzh2SQgTqS3bzCSDn1BuRjwiRPmkgivnwlf7Jkcttr6hiZwXVPcBPMglrykuSxmxdyTcXJvDyUCWY+JWmd22lpmUXE8D70iIc5krOLkM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXcRsk0EHt+Ji7wSQt35UxgAgJH8VoodrRTwVDHF8Wg=;
 b=izOmO7JDbrld15j3/sY5bbk782y0UkCxalo6xQWOJvJlXFaMKmziyC1mD8psiV6FjiiZygq4URqO7jLHEMFq492e3IBH2Q4jWQjVupv0aSUI8CTWwuPaO9MbOvNazC+s/AFSaWfNVuqAgSSbIWOHHhOKlFcsKY6LVm6rHMnP6oMuWYQYZHdPlYNBorEqdlLAKB4TAYs7POv+z+WnzqUoKAHpN8HmRlaAYCD3+etwhO3K37NMRodJYe6x9yojFdereRra+IqTXu1Fh7cUIX75SibB7WD951ugduV1cG+5uDoP7GxZ2qHeZ7OZ0BxBgS2YdelANlsz7Ymm39aCQGcSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXcRsk0EHt+Ji7wSQt35UxgAgJH8VoodrRTwVDHF8Wg=;
 b=Le0dG6csW+zwMOkIgs0SlZBlEm7oxLimHfKBMwtPVIUvWp8nOTM1sdSaH14AlGQw265g57hpacthbtPYxwajw5TiDN6mW2YcCDBmZ12ejS4dgG60dSav0JSafIT9tc3noUb35bu0RpU1IsMpKIiHnxxv5S31WDcZgEJowlWD7Iw=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3427.namprd21.prod.outlook.com (2603:10b6:208:3e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 23:17:05 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2%3]) with mapi id 15.20.6134.013; Fri, 17 Feb 2023
 23:17:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Subject: RE: [PATCH v3] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH v3] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZQxCgZcxYY5wLgESwq6crulPUna7TxPqg
Date:   Fri, 17 Feb 2023 23:17:04 +0000
Message-ID: <SA1PR21MB1335BBA8DF84AFDDF2E1ABE6BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230217204411.212709-1-mgamal@redhat.com>
In-Reply-To: <20230217204411.212709-1-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d490e464-8207-4eae-bc98-822cf1744ba7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T23:14:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3427:EE_
x-ms-office365-filtering-correlation-id: 600f70f5-12df-4782-add9-08db113d153b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ru6mcRCvQ3jlcrx0xPsoTPqsYcga1PoeVcpaaSrCSxxCfYMnPKcwXvdQMM3I4fYZsIAmNg9hmwkOrhEsWKpPcbyHti04rH8tvVrOIV504dDZ/LBp/mtwyRV+PHbwRG3wrPKOe4Az7WLd1PvbXcdxEkSAQSCJNR2BWachVD9k82vkHbtf6DZYFU9x4qoV66vo1/Bo1KmXdir6CEYZpBXYG7VJj+TnAakGVwinAfrDcpaRab36cNI97rD4eCpBQiyEiyxgx+FDU9XI5vLLam7nzadHdvK9Nk8YweA0MswooMGrOkWnX3eS0jQE5z7wKa/haRGcm8nXObapOJwcZmf6xK62R1W3Qp0Hre9zZxP+FUjtCi0Oyyq659vjrDMXKgEzAnknCzuoohQLAyxhXMm39p7hOEaf4C1QCcZm8YyOoRmL3rVM2YgVXQUn88Q55wWXc3ZknjRp2siqzk3oG84KaRRlMBeDGc91ts+9nXRGIhdgFFuGxMjPHMwFu6+Dz/N8mwMU82V4blrJKFvNcrRQQ4EGqWWoQG1eNuWTIyWb2eKf+DoaeB3JxA/hoP+CSq73mmyJMinMQ+04hN0aoH7sYW3Qzp/K+z3BPDqNbXHVZuEKdwRZUIBy35cMqFQk4EsqHt9BLEmGCdRaBEJFdMRU9FCwvNHTwDtHgdVlEOntdRVkH+i6fQzZDzuJC21dh4PZNxAgxaZIWSf6x5ybKL18OTeaa8PcwX5eFv7FezdzkYNb/fZMRjepNKGimh77Jeq2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199018)(86362001)(110136005)(54906003)(83380400001)(9686003)(186003)(26005)(33656002)(55016003)(10290500003)(64756008)(6506007)(5660300002)(478600001)(4744005)(66946007)(2906002)(4326008)(66556008)(66476007)(8936002)(8676002)(41300700001)(66446008)(71200400001)(52536014)(7696005)(8990500004)(76116006)(82960400001)(82950400001)(316002)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Srt7j1vWtqi2yfmbRvynQ1B6Qepax80lbDv3yDwartaiB4jws0fOKS2F3tCE?=
 =?us-ascii?Q?sTOg9JXfaNsq8esJUMhxZVxs1e7IYZyHBKiz7JcHCT8qrgIRVKMoIoCWBHcZ?=
 =?us-ascii?Q?GDgO0aZvhMvwmZ2tEys9bhVdzSj8nrzb2Cs8ziBNS2D8+9nXHV6bLb73eDVo?=
 =?us-ascii?Q?S6BFuvVGhSAeENhT0Uublm1+PvurJSVeXlGQTvjSmoZ9cEUrjPpKCmiv4q21?=
 =?us-ascii?Q?QIZZj1ROykkjKrxaeHj9HXpSiGlSoMfgXmU4KovfqC2zC+Lj/l4n73CPHFit?=
 =?us-ascii?Q?f60wjmyjIgkzlVxeK0M+Gcu71iCvAbVfPVHPJlEEfaC0W1LDXIPcC2Uzmbzn?=
 =?us-ascii?Q?A7irGwQXdNCbFcdY1YPm4dpjZe3A9kfmhzl07rpY6j/N4JuVnXEJJ4bpI9xG?=
 =?us-ascii?Q?b3MxA+FPCbE7aDHfuCAa087FAXdOX1u9dRLUkbqn2oHM6DPg6FrJg+fP+Gq+?=
 =?us-ascii?Q?ur83s3rslkuTLIHGfMKV3c2Zes3ECc/KOB2vb5kc4Zfv8s63rfVQTXKcO0UF?=
 =?us-ascii?Q?KYCuRL35YUZ128CUftERAk7+a45YAcZHav4SkOl3TatnXR530ULlCkBKs85z?=
 =?us-ascii?Q?/zYHtmYFQYzUUu5GfX7oPfKspDrzhYzsXXbnnLEd0M0KXD8Mis+8aE8/Mz/q?=
 =?us-ascii?Q?KYiHt7v64qcCcuIXcnwglbsRJItasRNMfMTRLJROu8nNq6ddvDMyXoa4DDAv?=
 =?us-ascii?Q?+Sfu71gbFegOj7Ae3Xm8t+LId77eDi9ljBqAJ09ZElBIs8CFPzbHXmQZoR7P?=
 =?us-ascii?Q?1cHE/PDeGXDa5bCy9s79N6ID93zyfsZTDEWQLJvofCyOJOXI74UYc7nHtYu7?=
 =?us-ascii?Q?G7ry6EwLcV7SwBYvGUTVMIDuMdpOnblt4yXE8JG6KhFqvcJL+LCQ62KZMMt5?=
 =?us-ascii?Q?4i6S25IXqo0fH3ZzoB8qiD7XXcOOlZ++b5Kl7DbWll5hVsmb3jjlTBoa9x6n?=
 =?us-ascii?Q?GbvQ3sSfLfltOwXO3LVwhLzen1GutHvkydAnw9ApNNnUS2ViT1X9QnywNy9L?=
 =?us-ascii?Q?VElpgTd4x2WxjGqe2hnhdSgDF30ACf9zEhUs1NruBKVXB6fmtA6y/4F/3A9+?=
 =?us-ascii?Q?rF+UTOaNI9CQ0VVcWhvpbTMbyzvT2PRdNb++n2X2svXyA0wouwTR2SQtIqJl?=
 =?us-ascii?Q?fnee6nuwDHQq5w1rTKAOz56UaDebuurzjuw8cGLdJW7Gp5O9YcMuB/1Mi3iF?=
 =?us-ascii?Q?LndgW9hD1m5GmEt5yQDLwpmdK599zXqrBvQhIiXO5HsQmkvJ2I97+FRaHJFv?=
 =?us-ascii?Q?lfEgDsqLPxTdz7kcRtPso9+7r789gZiKOEVZTSc3Q3HNXHRNgDdC1WnP7s03?=
 =?us-ascii?Q?nWGpEdICNdF/iEyYtGsldKILUBWKA2xrgb5thdLzUAoamnukv22RyovQsmOt?=
 =?us-ascii?Q?uVNbTXR4jUPTZBOpr6oUfpTOJ4pUakdZdU0UcwISWegSMRT2Ubo/mX7Pegdk?=
 =?us-ascii?Q?yy0mN+InoNkpeyKToL9lCK4YbHkXhygbtUAEWa4AJQpAhTG/GDxz61ARIyWT?=
 =?us-ascii?Q?lQ0ZkE0vDuabe/4ex0nPpa5qAfPS6an55yQPnjxsvxJFUmiQ3YeYpJiq3c7h?=
 =?us-ascii?Q?VI+CRRgKZq+HsomhQVCPhhHZ+SXTp8Va3dqA4PW6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f70f5-12df-4782-add9-08db113d153b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 23:17:04.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/XA551oUBb6tahWkyu3/DOAf0IkizlFqwH5gG8OTWnEyTdhj8sA4pzRWhypi4Cqume3rhTRMtPGblGWfaVYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Mohammed Gamal <mgamal@redhat.com>
> Sent: Friday, February 17, 2023 12:44 PM
> ...
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -409,6 +409,10 @@ void vmbus_disconnect(void)
>   */
>  struct vmbus_channel *relid2channel(u32 relid)
>  {
> +	if (vmbus_connection.channels =3D=3D NULL) {
> +		pr_warn_once("relid2channel: relid=3D%d: No channels mapped!\n",
> relid);

Looks good to me except that the line exceeds 80 characters.
Please run "scripts/checkpatch.pl" to detect that.
For this patch, I guess Wei may be willing to help fix it.

> +		return NULL;
> +	}
>  	if (WARN_ON(relid >=3D MAX_CHANNEL_RELIDS))
>  		return NULL;
>  	return READ_ONCE(vmbus_connection.channels[relid]);
> --

Reviewed-by: Dexuan Cui <decui@microsoft.com>
