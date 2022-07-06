Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF6F56921D
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiGFSrv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 14:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiGFSrv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 14:47:51 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82228704;
        Wed,  6 Jul 2022 11:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQkQ/DdX2cz+Xe4nptrSDxl7MYLVEa1lXvWl9K0CHA2XwYP/gd5HKkRVrHjz1HeZbXiUkYpdvIQIoCxn8G8QQ0vPEt1a5s1MDvZR4CImDTgcAJCROxyVli+4pg07keGDhd7Au3OQVf8zHbB4YWx9f3LG89LHrAW9uYffyr1Ci6LyxFjFRqW0cE0Ya8zFa8Shj1ulnF327L2GFHoTn5xBYiSKCTRF5wO4lOub9UjXt/cVETimGHDwRtG1KTVDGQD20zgdJ+TjZu48Rg7/dAMRu8NdznklVBDGmCJK4IoZ8pTlEeCgwN1ZUmNOM/XjshdGA1dcXpmumzaZ/W34mFb96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIQMdUTf1I06LG6IoOkxVJHms426gEMIX8ts7eqZ23A=;
 b=UExv7hbn8MZFXjX7tAjyAbOCqGrJYCAifAulc0ClmaNkLc0jE2w77lmsRAEWthizZYDZlkib8gU1qQ0TnncCeimHoGrs+E6IEB+cA3CoPcEO/vy2fmfMrP9Y3vNmZttB80O6ftnKos37oZfE6o2BgEvpCgFMDV4YQx/iCGUhK38ITD2t895SPIun5GF/vtnAx0ZPtr+mQB1cmRA4mW8FUzJlKaoOWsFyRc2+HCZOO+GFmqWlONSiTcJbRJszvrZQ6T7qBNjxgMzUVQKF7dZO2GXWjsUSxnhKis+dyzu+Dh7ntBk8n+L0Z0ENy1ZkLo8dKIEvPW9BknX/mI2OtgV1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIQMdUTf1I06LG6IoOkxVJHms426gEMIX8ts7eqZ23A=;
 b=ce9owJToRB63yES9jYyNxpONykAPUVSZH5Vf1ch94eb/vMhG/1I25WeKoEC3ecoeuNssgtBUo/wFLyIQsj7myjgJvy3gchZtzui578aPDsOzg7YDiYbnUIELqeg98V2qrjip0BY5JxORHj50sEgBtSkHVxrh4fd0c7BvPyJBwL8=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3311.namprd21.prod.outlook.com (2603:10b6:510:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Wed, 6 Jul
 2022 18:47:48 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Wed, 6 Jul 2022
 18:47:48 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 3/3] Documentation: hyperv: Add overview of clocks and
 timers
Thread-Topic: [PATCH 3/3] Documentation: hyperv: Add overview of clocks and
 timers
Thread-Index: AQHYkIYvjumTIE2L2UuibLbjG1DoJK1xqoMAgAAFgMA=
Date:   Wed, 6 Jul 2022 18:47:48 +0000
Message-ID: <PH0PR21MB3025CC907DD07AD11FC914C3D7809@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
 <1657035822-47950-4-git-send-email-mikelley@microsoft.com>
 <20220706182534.kh2f4qmjss4635bf@liuwe-devbox-debian-v2>
In-Reply-To: <20220706182534.kh2f4qmjss4635bf@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a75de09-48ae-4391-a4e9-1b58dfef695b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-06T18:45:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af0adfdb-ff7c-4f5a-dcd1-08da5f8005b9
x-ms-traffictypediagnostic: PH7PR21MB3311:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AoLMioeHz16Qwf1dnov85eDCO13lMJNSkURnmQWOEkYMPfs6OOqIVhshyAEvdbGMZYSng/SF8a2wqp7dXFAr0t9EfTSKANVhM0pqgLGGskKnH0L6HfBo4VqpjJ4XmuvkBPWmUnVmz0tLfu4FvmXLBNiEojGj+J8FDRMuohlxT9gNlfiulbJJNEspxTPn1hr8BJN9TL/lT3drp7biLsmI8daFyjcdPlMQZdAcIIjCgXco97iW+pEEmDew+taAQbh+wk33PofMNRWhO9EWJlVQ+GA3hV51+CZJmr4sblVYsevo8O2KVyqUwMmiNvKdJhLwvRiFhsqHP28Etd/LMz5t/IVa4bg7qNdw7/hljQB34rBJilJ7klWTtcMucVYmUecJA1DLbCrCBSqEl+FbU+xidiksCpM71ES5ETwA2xsHQhAsxcgO0vuJXb8Uv7E14LXXECBWujhs6BWddnULhJDNfgqmegEfLpFjNWcsnIfxFxHWJqQPy+x5gm9LfgfvHXO2Rcx01bRMOENbVJvSoNwLDY0Di2M7U8Es7LLmChqQBtfZw+PItWy9hWTOCjojvGnexggMfMHCQBJ72F3p3oSEW4ZW99Ijxrfcugfh0Us0SM7PKPsawesQ4JweQGylAJTX0PP8f3Bl4Yxlc3MFYgavBln1CBF/TEVqVoNLo2nYvewunnGz9IRiiQx7ghoduqNOSnn2CWDlDWPZZX96AW2d7SerxQxdyeOQix66xr24J65mIE6zyj9+7O9O13G/LOaT3CdktQlxI9AE0HE47Xv/H96mYGcm3HE5Yt4kli0Bpnsz3UmIusI/LoZm8IlGfExa0hBMjdrnF8IjULwSKITnzaEFIowVvaUeprAF1IC/tzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199009)(52536014)(66446008)(316002)(5660300002)(66946007)(86362001)(76116006)(8936002)(38070700005)(66556008)(4326008)(38100700002)(83380400001)(122000001)(82950400001)(66476007)(8676002)(64756008)(2906002)(82960400001)(186003)(7696005)(41300700001)(6506007)(478600001)(10290500003)(6916009)(54906003)(33656002)(8990500004)(26005)(55016003)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Suaxq7xaf0XhCB2SGpbuYSfJXz/87Ff/tkN2yKNXEvNBxxYpgOqCZ6F3oybv?=
 =?us-ascii?Q?WvHu1N/pVv5YDHyJBJi9Bm96/2uv3GU23Im5eXLHUy+ZWamu1Skcs9PnYdRu?=
 =?us-ascii?Q?1Jk//sn+bNYXz6qOpHbnjonoo0GhH9m+IHGr5loG3FEibt6eXvkxrauDFxJB?=
 =?us-ascii?Q?uy6VoHQrb8cgCDMmSBecnkSXNbV6KF5VQRiwBHnRLvlmfffLBUicrCjy9Uhp?=
 =?us-ascii?Q?xWa5EZYlfK0tHqL9C5FXLGH/R8LDWweCNPPTi17LCPINLpgSE0vlXrF1Ausf?=
 =?us-ascii?Q?TxChM332lwaGaIGIZO97eKDA3DZz3o6vhpV/8eFUR6E3yqodWNiTJW6Mu3pc?=
 =?us-ascii?Q?oWHgRyOKHB+fiEG9kxCZIf1X6A9XBpV8I36ax9Kf9l7ofRaU6xjJFAvM77/A?=
 =?us-ascii?Q?mAbmPpVhp7oc/KiKAfFkNk/a2IQGMykLu7Kkxz/gPJ8cZIBUrkKTTI4sDP6p?=
 =?us-ascii?Q?zy6MG/abLEM0XV9IU4xrtg4IPMOa1gRS7yhcoa/3Lr8yRlBARc6YPbomCIta?=
 =?us-ascii?Q?/KQ7mg544UJolTIeI0dGhq7agGmEJRzwcq/4LaFP9LGpNSwkoxJ8qjGEJ7aA?=
 =?us-ascii?Q?KSIf6YH2MCoytzuEwBYkY2arWPePFjZc6aIGn/BITLEMxUHeoMN/k5YveTOh?=
 =?us-ascii?Q?1Flejm139rdRw3r5z68fF7IQ8W4MlOlcbfWnbU5hX328fQeNQFhp9o5thDnd?=
 =?us-ascii?Q?lCtBbWYX6BldiaWhSEzBHOtJzmIwoDBp3+nwPLRdLcugpi3TjXOGCOyQkHx9?=
 =?us-ascii?Q?avQOu8QEkHIcJtpwMMT2dfPCF9aghdx3aTMZ3i7GS7VgOozLubfeeLbo3MXg?=
 =?us-ascii?Q?DaaWZGwZbMbKvXSGqvNcjW+NglRyTvLAVlDmIOIJG/d8smJtYpOw85oTw++T?=
 =?us-ascii?Q?2zQfoZE7eEGTyCmGRAdU98L/jOlLFCe89j0UKxwlHWLFUusqdOUHSpIt17bJ?=
 =?us-ascii?Q?qhRQeA1JcebRMrqRyZ0PFXchUvbRNPF9plCr3TCN4PmE0wyuxUdIJzrhkoTs?=
 =?us-ascii?Q?O2L2wZJT5p8iGRp5CvHaS/Bp37dTSt7NwZirBuYSzyopom56XZOw+rBIbtYO?=
 =?us-ascii?Q?gWI55P/s1JnrQZKJTEi5ZlBpHkUgYqpFNIJO6fzAeqykj7Uaptwce4kUiJbS?=
 =?us-ascii?Q?zWBm1P2Ff6gObcDcLZRF06ACH5DL1zMa2fepMUSWN2RL6C+tZubqovcnUtnE?=
 =?us-ascii?Q?5EZhulAHShAP71wQHOiK8tv7UNLuVwYA21n/L4mZ5iWJkd/bzuQdtmAXMNB7?=
 =?us-ascii?Q?gtIXDuTJSQ32Hum+kGForZPv+0CGNV7/53+WFMH4n9YdrlPNAuBL1cHrj4Jk?=
 =?us-ascii?Q?GtUol9zoR4X2NfeTdB3DuQ0PJajIndPAiN06QnUEGK2HFUTNZ0u6YwFGzi87?=
 =?us-ascii?Q?n50n6a4ucTPIDNTohLnzfzRkJI4za/MGwWo29YxRmIZ1WUjy2AGPyHJSBy2q?=
 =?us-ascii?Q?DpNE9r8gMhoxpK+FgnmX102rlBX2y3kq/ijzt+yOv9WDfLJgBCLkNPe4ORzV?=
 =?us-ascii?Q?/yaAUW3/bR+h/27ujAt+4jIF4vHFhpYb2jEZgp9G1EX06hGPDSOO6R2XygNy?=
 =?us-ascii?Q?5YKyIi4PdGlxkGktgAVBHAA7Mhj7Jlfrt9e6WpbycbSF4STMyiwbrRxpeWQU?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0adfdb-ff7c-4f5a-dcd1-08da5f8005b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 18:47:48.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqC33UL1+oPQvB1JvFlXpYMRdiccPrZjVcvXMIHoPPleT6p1GrWMO2BuNgLwWJCDeu8+0idXbv7fBAR0nzkdWuFxtpKNXe7fE3hKqKQFlg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3311
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, July 6, 2022 11:26 AM
>=20
> On Tue, Jul 05, 2022 at 08:43:42AM -0700, Michael Kelley wrote:
> > Add documentation topic for clocks and timers when running as a
> > guest on Hyper-V.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  Documentation/virt/hyperv/clocks.rst | 73
> ++++++++++++++++++++++++++++++++++++
> >  Documentation/virt/hyperv/index.rst  |  1 +
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/virt/hyperv/clocks.rst
> >
> > diff --git a/Documentation/virt/hyperv/clocks.rst
> b/Documentation/virt/hyperv/clocks.rst
> > new file mode 100644
> > index 0000000..e4ba2890
> > --- /dev/null
> > +++ b/Documentation/virt/hyperv/clocks.rst
> > @@ -0,0 +1,73 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Clocks and Timers
> > +-----------------
>=20
> This seems to be inconsistent with regard to the other two files -- they
> use "=3D" signs for the title.
>=20
> > +
> > +arm64
> > +~~~~~
>=20
> And the other files use "-" for this (second?) level.
>=20

Fair point.  From what I can see, it actually doesn't make any difference
in how the HTML docs look.  I didn't succeed in generating a PDF, so I'm
not sure there.   But I'll change the clocks section to match the others
just for consistency.

Michael
