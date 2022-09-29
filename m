Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55575EFF51
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Sep 2022 23:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI2VdT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Sep 2022 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiI2VdT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Sep 2022 17:33:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690871CFB89
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Sep 2022 14:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+XDL/iAJHOrNEUKeSlBvw0Evq7H+Qk8CEszkxgcpaH34l3bs/rYSU9d6yu4bFrD6gLWGmAyjPZdHaNXDUZSXlkglaBzXH5250dMflA3MlNkX1QKMaLYgGSKKkdArapiRAayqkNmjzXtSR63R6PBZlnz5Xf5BXMsAGcTH1v8AYFdmjbfFJQy5Y/OsHkalsV8i8Tc5KEA9DDgUmN5UscCyNyAjzkWZJ5SHpJORdEoAfSQ/CmgiDG5qd9imQlC51b1dqH1teI9i4kJeooWcn99p6Cokd3YD4mmLTSanqN5HCLtgOTPgfS3M1qN4N7I0OVDz+6oMz2yeKadPNwTCtGu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HF7gBEAx2ZJTq2JQTpdjjCD8GA1SwDYOZU4HXtc4O0=;
 b=Fwb24zTytNNpLDz8ro3qVlU8UOeGCUIkrZ6NsHC+Q4erRXoI/0FOSXl9kLDiZiB9y+Axb4+rcz5+r/GACrnnwbvlfe59mnXAJ1XWGINDMEOAQ38ZTS81JW8SOt1jpz62bzkD0QGZDxKBBizkbb1IJVpAVxHkjHpV29K6StiV3WwTZ5KLcXuisJoMPK3SEqa2ZkJul9Hf4bLZXO4E3QATaaPzYuyKPhBrEie1rqqDt3I1mOKvYwWZ0e5fk+0QL/LXTtTvlrlkX3WmJsKw8/mlSn6k53+3gLtPFq54xr/qI4FWykvBOkv17aRznjOt5YoceSiitKSLSuRJW8HAsrcWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HF7gBEAx2ZJTq2JQTpdjjCD8GA1SwDYOZU4HXtc4O0=;
 b=ZpGxCotwDJo/7AXXvGqeSkWS09C0+BzZ/fSvbK+vHTUFlE2ZYbPh0ECNbCKfvusrrZ7io8y7mZ/5VrSNrRpaeN3dY09zGtbZk6ncUmBduGy/f4SAMhotOAZ7ohCFA1CjnxWXSwvdlrEcxijRT/O3BZSNMKqAyMgtk/499uE4irk=
Received: from BL1PR21MB3113.namprd21.prod.outlook.com (2603:10b6:208:391::14)
 by SJ0PR21MB1949.namprd21.prod.outlook.com (2603:10b6:a03:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.1; Thu, 29 Sep
 2022 21:33:13 +0000
Received: from BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::e662:d0b7:93bf:619b]) by BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::e662:d0b7:93bf:619b%7]) with mapi id 15.20.5709.001; Thu, 29 Sep 2022
 21:33:13 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <sthemmin@microsoft.com>,
        Gaurav Kohli <gauravkohli@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Thread-Topic: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Thread-Index: AQHY00EEpavH7b+Xk0qDFQ72IrNakK3234qAgAAJnoCAAAX8AA==
Date:   Thu, 29 Sep 2022 21:33:13 +0000
Message-ID: <BL1PR21MB311302D81AE4F95061D60FCACA579@BL1PR21MB3113.namprd21.prod.outlook.com>
References: <1664372913-26140-1-git-send-email-gauravkohli@linux.microsoft.com>
 <BL1PR21MB3113EF290DA5CE84A350D6BDCA579@BL1PR21MB3113.namprd21.prod.outlook.com>
 <DM4PR21MB3539D38A74B62AFD95989581CC579@DM4PR21MB3539.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3539D38A74B62AFD95989581CC579@DM4PR21MB3539.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1ac951a9-e996-447e-b217-58dd1163c49e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-29T20:35:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3113:EE_|SJ0PR21MB1949:EE_
x-ms-office365-filtering-correlation-id: 4e4675d2-db1c-40cd-baad-08daa26236a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NlX0abE2Be9K8dnnS0Ucq0HEltm7T3Up1bXMIMdobFxME1E3AJ7C9BkvXR4m1QJuIY4GXufM41i8PKg4DzjJ3kcEN5zoe0mm0AbFp8O+v7SueXYlKLZwrW1RV+b/kNVPcdEkA2y8lOZm+dE75NKvL+gwDl20KrP6e/rFLUgCaDAqGGoXitaQW2JnTX/pIxEZcTpjajSxaM8GBwkO6b9+F2jBPYHMRzgcw9Os0LC5TUtEdwGS0JfldVCE/oOTaiI4u1wlfMMTja7i1so8Hkcb9YqtjCWpbLXt6NMZ6IGiJRDTD+WjhGsXVDzcJpBXP4yrN5M57qqv4CDEck6RHkauDl4tzqGJHf4snTlgVLfL6+7uhkCPoh2hGBAt9Yv6TkroMqnYoHUYHBsI55p/iLJJdYVKyyFBomkYbISsMYIAJKwwno5T2dvr6Awm75sxcuYhc9IfMeZoO3VVtMpPWVwwx/amtratCHg0j6j7S2Kvg4tejz1yho5wcPlPvHIR49oWWewpo0i0PaUxME7NQLy39IKvwJGLEv/2BfUvwWZetxAKGmT6Tr3fxMjg37ODMluMgQKDLtlo5NL9jO9JmU5vh0vPANLfCnuQXceHXR+yar/itOKCxdKa6xH5YhPC/jaC6sNjp1x44fgVVExohATFAQEPXz2RCOBEt6/R5qf54+G0UCE6QAwk/LHdrugOH7MpPEsX7jeMUIpc4gjhi/4KXDpg+u6kHr9rwMl2zcCumnwdX9ShvGe0Xo09xHErlH0DrgyvVJA+jDH2UPivlQf98/3nm7vaHNSjmjbuV4Zbyo9wiMrSZ/RbG9S+nGHXtT2w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3113.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(53546011)(71200400001)(64756008)(6506007)(478600001)(9686003)(7696005)(26005)(83380400001)(186003)(15650500001)(2906002)(8936002)(8990500004)(4744005)(52536014)(66556008)(66476007)(5660300002)(55016003)(316002)(76116006)(8676002)(66446008)(41300700001)(10290500003)(66946007)(110136005)(66899015)(86362001)(33656002)(82950400001)(38070700005)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pMCC9073cyUWpryjFDa4PyHedujDSj4CGH5hlBFimdtsans1Row/n4NmG3Hs?=
 =?us-ascii?Q?HiFbv1y8TwRiUJATitspel7unRfjxlirz42xhGXVZsv7MCJkup+KfJSdBROV?=
 =?us-ascii?Q?UA8+OOi3PiqJO5s+Ntkfn+5VRHTnLON0jp8shoWqGDs3kEJd8nKcLUCsEfp+?=
 =?us-ascii?Q?A8/JfI5cdcQ3W0fDkJc1lkUJiJVzEUFmRC9+tdylRZgnrNj0+YYYx2qvKhAa?=
 =?us-ascii?Q?XCKxgd9+Yg5KYk8SMnLSCA3CMmO32H+nNIsDeiZOnsy5xhTAXtPL4Oy71GZa?=
 =?us-ascii?Q?homoCcPSTauld05AguIJqxfJFZ6/R/xnM96JAGBj944aqr5iJPv1Yn/3PmQV?=
 =?us-ascii?Q?YvZ2r+MguuyoLsB1fw4LBVMaxJEBqeH9KJBQpG1BKLAOeAqdIspNo9RjFpsK?=
 =?us-ascii?Q?UJKFjhB0VwZG7CKCu9qAl6Z+FKWPwQq+aZLLfvFcRNCfhHoA+G6hXcjvXmOi?=
 =?us-ascii?Q?IcMP5EMPta6hC+okUTZqHAdqSCf00/s2hZ+8J+4Z5a8JhfTygVJxZ3p1EGFY?=
 =?us-ascii?Q?8NkSQl/40BQzTDMoCES9/2f2Y1/5jO9DXantjwBlbcEOrQpjseY0WAAYbCHd?=
 =?us-ascii?Q?lw4GY5Ss18rPWBt98zzyZy8i16H2uN69bccYtI+3feZpGBOLt7LE2Zt/CFDP?=
 =?us-ascii?Q?s99ONBuJjwRtABkmxxrsvudeKlxRctPgybLTbL3kNVgvEHfEA2BkwAuiqF+o?=
 =?us-ascii?Q?WM6/NlxYAq/rKuPA6CfyCf8VVDIxO/a1pN2BxJHY8XL6RrwZ3RJN4zhC4hcI?=
 =?us-ascii?Q?osstV4RBVqKT4jOivSUJZx+9N+H6KR0jZDmJZ+IruiTzdcEYCv2/J+Ci96kq?=
 =?us-ascii?Q?h1oawCNsD/enTbalVvWmOV6hy8pT2FwFcOnUrLYZA1AwvCT9zHwq2fWd4G08?=
 =?us-ascii?Q?HL1Z0sGBO5lp2YGWKHEgT7twTI3oO9T8Uzy8MPdWpgW1zAHY8GzsyV1R6+LY?=
 =?us-ascii?Q?KWSJPAJ4uQpO3Uf7nX2zgNleD7alfo+BkFPQ/dHaq/4QRCBTXVClu1DZyDJn?=
 =?us-ascii?Q?SYbznhit7fg/2JjIbiveHgxExrON1T2NBdU+vUDLYxzaEjR3Zf+qxthcH5TD?=
 =?us-ascii?Q?Xea+fvDu9xsHaIBbjBceHx/WmtWbyJgsBEEs4alDUYiq3htnmJpsJgeuaxmS?=
 =?us-ascii?Q?qAFr4PdxLX8iOL+dGIGhDcgzbHiTMYr0R2SmfsgbFDPSk/V1CgH7++h0fc5C?=
 =?us-ascii?Q?2EJZcqBt+bwjiiOsuhrtaXe25QHcgiorrd7ZKs9lm0c/vqMzx2tezyqKV8bO?=
 =?us-ascii?Q?2FHfAQwt2vDR/Z7GtYxuco8xzDPH+Y6hvZFN9/dLBI1ECtdYNDjQMiIUEAy7?=
 =?us-ascii?Q?hJR8rVNKqWuYtWyJAg2upx85CA5Btc0fsV0b5mRrOgDSgTzhqCKeQ9h1I23h?=
 =?us-ascii?Q?WG2IUkYqAky1cWRcDYePQrNdYJPJAyo4Rxoh6K5DdTWSen1WElr3Q2+/DWOs?=
 =?us-ascii?Q?xpYgB0gfuel9Ehifc+JKht5nvtM9dmrg12YOf3JmGS++4oROe7ERHHmBXeRW?=
 =?us-ascii?Q?OlG8/huIG66IOyVWDlJypdZ1UzhjM+KM1x1+5DZDnbpbsyz3Kg1Z17ROADz2?=
 =?us-ascii?Q?5mxl5KanVTjizZUFtJUwxX2H1CePTlN5iSMZsWy/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3113.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4675d2-db1c-40cd-baad-08daa26236a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 21:33:13.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuiD2Pk2Mk6ai6WSJdnDLY09Df6SxR7UwqJP5Ko6QrQdsQnITH4qFgsBYgB7G6V1sjvBLhURSX7knvDr3/JXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1949
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <sthemmin@microsoft.com>
> Sent: Thursday, September 29, 2022 5:10 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; Gaurav Kohli
> <gauravkohli@linux.microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; linux-
> hyperv@vger.kernel.org
> Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF
> association message from host
>=20
> The policy of network development is to not copy the stable list. Instead=
 the
> netdev maintainers want to curate the patches going to stable.

Thanks for the info.
How do we indicate if a patch to netdev list should be applied to stable tr=
ees too?

Thanks,
- Haiyang
