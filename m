Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E073A799
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 19:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFVRsH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFVRsG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 13:48:06 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020019.outbound.protection.outlook.com [52.101.128.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3A1BE6;
        Thu, 22 Jun 2023 10:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCEU3/zxIAnVgBbsozRuvwnJD5IfjPf2Lizrmx4ZdcbvFpvNCRu7UWR8evOPNlDssnArR3AAZ61bfJdIk1/D+EEi+ocXMdAAQciJiieAhoLTfo2uqLPo6x74x5LesHLhu4w5hXaznA1gClgSIEYG/9W+O0CwwoprWnTmZf3N5U9o7OfPTpy8bE0Ki55/w67lcCwRHf9m91BmaM4WwoXFLNVLCZjlBUi5oatY75+wBkIgcUamuATeb6G7AZJTfB5Q9sxR0AXHYH/rs09fxgKRl8P8uzjr1P1KmtpSxgswRXiyRy0tfagjSbA16stirL3/nA1XcD1lqyAQJ/PHfsxfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlbF97UVttvLmp0txjqL3KbpW3vblYbeifpT4nN61j4=;
 b=FFHANT72Lew4Ts3OSKMC5Aem8h3a4zcatrq+0PiQDAr4tiD32F3yc2kKVdrN3tvHpiOwiYdzhzkz1PPkcOw+2zSZhXjOecmP3GVCwbWytzP7jcXhnHll76n7TjrrKAKZNjVMav1ykVAncALbgGO/7Itbxgyn4vRnZNSHgnd5s/DoY2/m4nszGoiCph6pJFv2k8sxVc3WNR5pV1G+FH4VAOq590VCR+p/kOe4NZgY/cxrVT1Em0sgDDXyyd+YeMwNzP/XNYDqigTss3nPBal+JXYBgncD6CD7213JZ70WYv/eAZBLs6p4o+IOcXY49yPmW3KiUcAulIXcOHZXTPbggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlbF97UVttvLmp0txjqL3KbpW3vblYbeifpT4nN61j4=;
 b=L/Q/oRu2EOuK7TNbeC1ga8yQmXv00tnutbjgIkmI5c2EYAJ6xQY9ZsR7Uko66xCPHn//mA8rO29X+SIddhrlMa6DWEdNdZCyBwG7V2H/a29we/fT0wcoDnLYSeUlGclJJc5CD3mM47rt7XwiwHoC2BRGw31TSI6KbcuxoK5vmh4=
Received: from SEZP153MB0742.APCP153.PROD.OUTLOOK.COM (2603:1096:101:94::13)
 by KL1P15301MB0418.APCP153.PROD.OUTLOOK.COM (2603:1096:820:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9; Thu, 22 Jun
 2023 17:47:59 +0000
Received: from SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
 ([fe80::6260:f346:f62c:1eec]) by SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
 ([fe80::6260:f346:f62c:1eec%7]) with mapi id 15.20.6544.008; Thu, 22 Jun 2023
 17:47:59 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Thread-Index: AQHZnwV0dJHFjLU8M0ikMK1jJEcj8a+TL3RAgAAdzICAA9fAoA==
Date:   Thu, 22 Jun 2023 17:47:58 +0000
Message-ID: <SEZP153MB0742B43EC4E490E2FEACDA4ABE22A@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
 <2023061430-facedown-getting-d9f7@gregkh>
 <PUZP153MB07492FF43240CFD055CF268ABE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <2023062020-swung-sensitive-4866@gregkh>
In-Reply-To: <2023062020-swung-sensitive-4866@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aa4598a7-38b6-4a28-8f22-f9246d0d86e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-22T17:46:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZP153MB0742:EE_|KL1P15301MB0418:EE_
x-ms-office365-filtering-correlation-id: 2e9acd83-4337-481d-18c5-08db7348d151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byJqK1mUrYCDq7CWgeNHglmISF0B7uK/Be1HNUbwf2GYxWh8bEeVP5ySN+vAkC7p9yEwdSxF10Ath+mNjMe35khIH2MMRechvkzN4J7oQEmYja54rYtFlYXxInVZ0cQOrTISZHo/+z3Fz1tZps4u3acKbX5Kk5ckmh1CDr8t9H1GU+yKQGGGwCZD//LQjqXSPxeRze6DSd/7Wvbaj6gBN2UY5C6gR+0/E+9RkefU1fhyup95AxXntPjAeDZq9ZeDIlnzCJ/3Rrlm+JOpWpG0wMOR1cwjeuCyGrPOXx7MIiz1XVGriesOn8lZf3ZvfUNyomu+wNXzxqFpNeyHVxDd8y2zunM1O+bKrM/5bw3hoUqphgOnLG3+7Rhbb62LdVDblAXnMLm/mmprlVM3I4m8di2hDIAJL35ZA19Q/eQZ1bQ9EV7/B5wc5M7bBno+2S+/IsVUBMUlrM7AFAQ4zrbOBhEDCq/NNjbAm6XsWLLus8oXDYw1pAL3nFcENHHdO977fBpcq+IHoB+fKXaWG4VFL2rKPKxO4RqATZu00EAAIwwjZ1nq+jdRtclMHa4HMYcXH7SQiiaVjQ2XzUyDb5EdQImu9jun2sb7yLxbmWGmcgAjD6mJ6nhgszSMuEAn9txm8X09mXGakQdEch2oOPRjGoo2r0bOeviQL5HxVPGrkJI2a3hRdFR3H6MS1jQkP/Xr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZP153MB0742.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(6506007)(66556008)(66476007)(66446008)(64756008)(55016003)(8676002)(8936002)(9686003)(53546011)(52536014)(5660300002)(186003)(2906002)(4326008)(41300700001)(122000001)(71200400001)(82960400001)(82950400001)(33656002)(83380400001)(66946007)(6916009)(76116006)(38100700002)(8990500004)(478600001)(10290500003)(38070700005)(54906003)(316002)(86362001)(7696005)(98474003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NPFW2+W8nPVEEf5ed9lGJ4Ft4BbTls0IR1zDsbw+kiAvAx/T8Cc5ffoxD2wc?=
 =?us-ascii?Q?CFEVhOh68iBFdNyXWAjIGbWWcWYI6g0VP4aDotGcMWrKKeUcdAWd8vfDFJub?=
 =?us-ascii?Q?T/tzvSej7ikou0cawTysW7PFaZhLOAUlxJaFHAJfF8/EfkwsLf8k5NKbYwGQ?=
 =?us-ascii?Q?xcfsM1btGEb87eiw08kZLfRQ5Nkoym0ptrUaR5yiwuMxAwnrTEiK6t+BLUxs?=
 =?us-ascii?Q?YGNCpxJoX046HHXVIHtEdgNb2lqUKh4m7fmQHuW1aDhfHXaxMxP/c0IEjF/D?=
 =?us-ascii?Q?rlIFhMsaZ0HPG4y+K9DbOkHrfpTs9bzAUhjji/u4rbXwQvLxTpgzGiwmbzUT?=
 =?us-ascii?Q?Rjw/aBEFAWubaw8LuDMQMb5OtGjLMeS5ZICXFnNmudkTVponuQGq/q5cObUN?=
 =?us-ascii?Q?6vSMBbp0Wzxzolda22k2mFL41AbnAenH+DHxNjZxoxVppiYtIp9XCThG23pz?=
 =?us-ascii?Q?kA55z0qQ/4DexahQnjk711tHsrXOnoHbON67yHBFBpKgt9lv/jiC5zYu1CRB?=
 =?us-ascii?Q?skHIHYX9drQqx8nh0lLQvwfsnBiBubT1ogChBlhDvB9xSt4aHHZYD41E8spG?=
 =?us-ascii?Q?GuFf0CPD+tQS4ww+MkuKyZEMDQzWohZ/UUB0PSNDkzc199OovpSrOBHqYNMu?=
 =?us-ascii?Q?x+LvYWnjO6pyoA3td5vOXRgPKIO3YlYe48fagGdDUJfcUAORwIukYYjQCBEE?=
 =?us-ascii?Q?IfNi3uKrdG9Gc69Spew2CnV0arAQe0TmKN+uB5OXIC88gnjMJPsiLAS+rCVk?=
 =?us-ascii?Q?7EZ8GrzJbwRiKYuVJvqSfzIP66XWP+NHKNcthzrN82BFVp0kIdrGH1ChCDLM?=
 =?us-ascii?Q?U51f8aUxJ4n1i2z6O6H6PvjKeGK68YfU2E1t8AC1UvDrI3+6FnQEdw79ZZBz?=
 =?us-ascii?Q?dKsmTX/imV9qGQDHH6E9pvPyY9hEXWwCIqc/Uy+b1CUKoDqAMyQHxQiWh35l?=
 =?us-ascii?Q?95495r1eZJVBV88uzdY9GyDRUYGj93bq4gEjImnxwJ6eLLxx7U/WsCTRbhH3?=
 =?us-ascii?Q?necJlb2lf+bFt7l/A5uJVtG524mLkGaRg11PlNgT4QKEiFpDMVoOIuZ1hdQD?=
 =?us-ascii?Q?q8D2XSZ6XtLglG1lu9SFJeVuGApXG/XSCUStIlCFWAdVk/Q46dCN++Rs7flb?=
 =?us-ascii?Q?Vekmq48ei+ESeoIMDKpHNL7/yT1dYQ2LVSuNJ4DkYzWCwuQUl71Yj+eb+Lj5?=
 =?us-ascii?Q?Dr8PHYQVQQeEIFh36mtRKB6SUO4Mu9AplvHBMOo3FInEUZPd0PrSvtHkUSJH?=
 =?us-ascii?Q?xLZUHtIt763bkcFParWUVMMvbkN8J3KxLekXJTeOTrPQZpdshQLd/3agnzYp?=
 =?us-ascii?Q?4QYtzotxWQBrMYEIN9hNlTKDrQ+I6x4PV7LnZ0egcS1LCyXYkvP6e4MucGwX?=
 =?us-ascii?Q?U3lThWvi4PCr7p52/uRPDVpaE5gTqOmbOiT8LrviK7HRatV0Q6t1yxE/b8bg?=
 =?us-ascii?Q?zqEPrm9oWI0Iga5TBy1ul/9CAhCE4rASXcr0/+r+IDHYcGbCuk2VNOhPI6xe?=
 =?us-ascii?Q?vldzklTf6zzSnAVfX1ITp0CLyNWQk2bi4CcCUic5+zy+s58qTA0wqKLRs+tO?=
 =?us-ascii?Q?A0baIBdvttQcLj0FSADsdZw/E6o5C5Dc5ebZnVlN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9acd83-4337-481d-18c5-08db7348d151
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:47:58.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a07kVFr9SU4FqcO/9Gr4qNnjNqWSr+GQly0PXLNL86nq5CuHW8OwLxnKHYUAW+eT757Nb9OmnPNntCzf9nbGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, June 20, 2023 12:36 PM
> To: Saurabh Singh Sengar <ssengar@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; corbet@lwn.net; linux-
> kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
>=20
> On Tue, Jun 20, 2023 at 05:25:06AM +0000, Saurabh Singh Sengar wrote:
> > > > diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
> > > > new file mode 100644 index 000000000000..d44a06d45b03
> > > > --- /dev/null
> > > > +++ b/tools/hv/vmbus_bufring.c
> > > > @@ -0,0 +1,322 @@
> > > > +// SPDX-License-Identifier: BSD-3-Clause
> > > > +/*
> > > > + * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
> > > > + * Copyright (c) 2012 NetApp Inc.
> > > > + * Copyright (c) 2012 Citrix Inc.
> > > > + * All rights reserved.
> > >
> > > No copyright for the work you did?
> >
> > I have added 2023 Microsoft Corp. Please let me know if I need to add
> > anything more.
>=20
> Please contact your lawyers about EXACTLY what you need to do here, that'=
s
> up to them, not me!

I have cross verified this with our legal team and they are fine with it.

- Saurabh

>=20
> greg k-h
