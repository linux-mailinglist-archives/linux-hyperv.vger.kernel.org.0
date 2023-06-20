Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D127364F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFTHmU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 03:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjFTHl7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 03:41:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779510E2;
        Tue, 20 Jun 2023 00:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdumK9c/0aDJwkbRAUaEqMRnN7Z7Hdiz6aoRhsMyGxz5LLxu5Q6+VVtryrJUUbKrBMT4RuB7ZPhyCL5QU1RA7us5ZxCHkI9Zkkow7FtZTRWSMz4BbpnS164ChjkDp8jFqbRCzP7GwzrXC79n+4JD9PCuwYcazfbEqAu6ngLIWIIxyTGZ75ltwnfoebYM+EHh++z9y4okPaHathlV9v06NE+4+6vjyHl3mgmRCU59KeN9nR19XxETYdQPUHQvBchuWBIRHqOqZ0mPLMAG+x1EUh912ksPufODs1C7bbyTFEstUBCTfcIpY+cy+bUn9DiMtSlIGm1I8xxhc2qbpjg6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHr3xjszEkD6D4UBjPuFCwjvacPYHbZoQzEkZAteURk=;
 b=mKZAi13a1VuAHOZF0+NGg4MgH/wh6Wio1BI98N6/R8/ifPQvZhvS3h41Pmeb2eliOAYbRvq35rSi5u6lgJnHPHHTR9I2wPYOJfBrvIea8QF5yZp27BfjHkZwquef9HCGPAxOD5riSZYZoRorSIneh2xlzvm9f6SXI1vKCMRSMfuUYEKR0s/ZwoHXKUmGbccAjiex3xrUc6y2SoMqUJfapp0ASacSzpNkuK9QnKQ/5KE8zAWXmAJ+81lbItb4s0GvRlvWNa8YOwBCeyV4E6wucZITi94EgTSaFnpFxIRKy20yhgoikNLT5XAxCIOFycE/aoyRKbuUYBTOpeOK5dZhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHr3xjszEkD6D4UBjPuFCwjvacPYHbZoQzEkZAteURk=;
 b=aWquvRA7192Vxfv2dWAjhxWmqipCgTh11ObWNgLIXAdf8viO2JuAHoI7JLUqANGxrchZHEuWJLjVqC7USqxdNDDPYfiY13LZKO4AdmxXOqdelc/YIjCvodybd80I9ry9YV2kUZj6hThqMxh8SPdbBaihh2sSqqqUixB1d68eteo=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SEYP153MB0779.APCP153.PROD.OUTLOOK.COM (2603:1096:101:b2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.0; Tue, 20 Jun 2023 07:41:18 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6521.013; Tue, 20 Jun 2023
 07:41:18 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
Thread-Index: AQHZnwURGv1AAiMyG0eDJttQESSN76+TLQsggAAghICAAAf+QA==
Date:   Tue, 20 Jun 2023 07:41:18 +0000
Message-ID: <PUZP153MB074979236806588A7D1B953DBE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-2-git-send-email-ssengar@linux.microsoft.com>
 <2023061419-probe-velocity-b276@gregkh>
 <PUZP153MB07490FDBBB8CC3099CFF126BBE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <2023062007-coral-nicotine-856c@gregkh>
In-Reply-To: <2023062007-coral-nicotine-856c@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b273513-75ba-4fbf-9905-2f2df98f427f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-20T07:35:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SEYP153MB0779:EE_
x-ms-office365-filtering-correlation-id: e5c2c79d-489f-4c3e-920a-08db7161bc1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/FmQW7S9wtSWploayZsvbaIu2tOYHepBDkfZUFeagzoOb0tPKX/nySkmO1sh6fU1FYljZfIGAD0nyXFHViQD7jSfykftSjHeavQNR6h5VvuDjIrJDYjH4L0TsEi/AHfPYzGl14zebuGzm2yuIUPNlSy23AlWsTmVar0O4i60REb2F/rH1q3MW4kvn56HNbmRAxJv3bGcstiEW2uff9xsWgzpEJ6b0Qg22bqZxLzcXkv0pVIPCMvDk0BzDbQt2GYnKd0rTI8+mo5DlJd3iWNaJTA0SCup4T5X+PQoXpbqLbtmCpePSDZS4R5NDSJXQz/cySMsA14eIgsmig2UZ7PweCX+ds6hi8AIo9xaZ6XT/XYZhVTCEZlqHj82K8OuDiaLGKQ6NP0CWb+56aMF9gWx0lONCDTRIhCH7NIAkRglYSEt91BdMxmDEfHt0Fh5pkGqSGmENmLwceSiZCTywIpIDreXYz54X0D8r2G+ePwiY3FYoeABdzenU/Gzgg+ldpAA+pPurv2sbmJym3jtJTNOCg6TVpnGYYEOdgR3aHVvawns440Xwn9lEpOxyHzDYddHlDUbQ98qaORCp1lTAYPihOtlxfp6G1ACOJutzZYyxYYsXYSS+xkTxoV6TrHdBrNZyz77v3nDKtwqkVkivq26FS+G38ASBippAGxsDRfnQE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(10290500003)(41300700001)(316002)(7696005)(5660300002)(52536014)(76116006)(8676002)(6916009)(478600001)(71200400001)(66446008)(54906003)(8936002)(66946007)(64756008)(4326008)(66556008)(66476007)(38070700005)(86362001)(53546011)(186003)(9686003)(6506007)(38100700002)(33656002)(82960400001)(82950400001)(2906002)(8990500004)(122000001)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MG5lKLaZkqX4eCi5Fd09SWyY4XRJMtUOBIrpbRLyvBuL5onYnuvrVy6AYTVn?=
 =?us-ascii?Q?9IuSq+l3+hCU3GpHwwf9kzVKK/4bTGSDXQsk2KwwRXrC5G+HY/4RCtlbHgEb?=
 =?us-ascii?Q?GgQWKm5DAZxW+xfThzhmvuvOyChvOmvTjXNTI/qa9fw0i7sUdtx0F1jdCu7f?=
 =?us-ascii?Q?QdDTsAP0fyhWAuxNGbPW1JMB79DFDOzZ1o2RaLn8X2G1N65bDtioi5LJZfWw?=
 =?us-ascii?Q?22VZJkNGbXsNij4Qlxil8mRj4PhiA6DkMjtcQGFCI8N+kV5Fr9QYqdbCetGN?=
 =?us-ascii?Q?zlCRiSHt9mdef7o3Byb/xr+kd6CC4v+FyDT8sZbgT1mDEaacOjWV6kb03vuH?=
 =?us-ascii?Q?pncxHobQKlZsGOxL/4TTOuFBBKwDuSKwUdDMv+Mm5nV/qQ69zDytyJtt+urn?=
 =?us-ascii?Q?h2ofHJM+T6YzxO8psDIjMOYEKF5f4r4+XmEy1113tbge2lSmiKMMcYZ+DDO7?=
 =?us-ascii?Q?CoWxTgiUbd/m7Xep+/dEJVDr364bHzIglGbzj1Yw/GjcwtoaFkT7Efw89DmH?=
 =?us-ascii?Q?G7juRuMN8NHsLt4TJm+3eB/ipuJXvhQZVTw3htEsE8gI3ZThrdAlJDxLJaxR?=
 =?us-ascii?Q?p8tCaJkfIRDfC29b9BNS7QzSt980jx7ii5iVkAD3AYUOndn+RJwcBDSZUkY7?=
 =?us-ascii?Q?Dk3670rueoaLMVlxLRdSNpkZRDxIiGAHxl7biHFiBGd7c2GeR8yD3SWX6qwq?=
 =?us-ascii?Q?7Xc0jSQoj/uheuQSwi7ufeRJj6pXqkMFJNmi8wK9WD+LkWDwG3A8fUnNSMb+?=
 =?us-ascii?Q?dL670zHlnWR3Qm6FaPntPscQBGpMJlJtd6QME28+tXvvQKi16S0repfl5d1u?=
 =?us-ascii?Q?FBb5+2I96HKyAT1OuEZcglcapbnsa4rLKn2ZlL5fpJBLfWStoNdmPJw7UqOP?=
 =?us-ascii?Q?TBlao3YkLWnJivgoP/2wgK8vTxrQJ65xePUNlYBhW+5+MD63BKsNW6DioX6W?=
 =?us-ascii?Q?T6brf1zQXPCbjiXo7Q0l7NIV25A9IWYiMEL8B/eDYiFjIpkCth2i3CeySQ+j?=
 =?us-ascii?Q?d9UyBa8icIl0xzx0iijXbc/hdFY5tYvbGFPbceFL5H0LQ3LU5Xt5Uutur7GV?=
 =?us-ascii?Q?TYPIF7S4DG7SLkDz053wWpWxxq2SbdAMsQliiNXymnU7OuZv/mrhMgpcfQPV?=
 =?us-ascii?Q?ibADvJwalS4kfKeEZ4147B0WeBfyi9iKnnq9FoZYhoobOqgAgq0EZjbn2YSx?=
 =?us-ascii?Q?kD7lsDHkHftA5EHZmFWgtaKyGtuPFZ8WMU3XJNkwF8mQaa0vsggO72z+VNtI?=
 =?us-ascii?Q?BqUup+uFqQ/unKIiBATQpUerBtD+Qmvon3VRxzcXSLPGMnHhcPzfesvAJMEK?=
 =?us-ascii?Q?+BQlw7rwPUsdKznwX53VcEOyXvpwOTsfZKWU4fpNFa/8Dain03pacd6Sln5Z?=
 =?us-ascii?Q?qa87rtxhumuV96o6ukPk2fJeBA6LHbhQaARBbbCXN5xSDBZyEWPJ7tv7+ejh?=
 =?us-ascii?Q?ZSYhG0T9XIYIa8RXPPSPxzyHNGwa2x9+yVIE8fKLEHAeJ8lrPVhK5kUhtq0p?=
 =?us-ascii?Q?LnXwpsab6Er+Bn64p0xqUc2tqrwNvvR9U/LjNMkPxmYnICnPZ79Bt0RyYjCo?=
 =?us-ascii?Q?9v7lsAxWmeCXeUR2fCx6vCOtRC8sDsdGNrI0Muc/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c2c79d-489f-4c3e-920a-08db7161bc1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 07:41:18.4606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FL9JVXUz56FnRLFVIs3SQW3PnET/ES9UkjG5hSD3wPK4leB0X04dDY7K4GTkK/XHuMcbke6XcoY2L0T2jB0MRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYP153MB0779
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
> Sent: Tuesday, June 20, 2023 12:37 PM
> To: Saurabh Singh Sengar <ssengar@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; corbet@lwn.net; linux-
> kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client drive=
r
>=20
> On Tue, Jun 20, 2023 at 05:19:14AM +0000, Saurabh Singh Sengar wrote:
> > > And you are defining a "global" variable that can be modified by an
> > > individual sysfs file for ANY device bound to this driver, messing
> > > with the other device's ring buffer size, right?  This needs to be
> > > per-device, or explain in huge detail here why not.
> >
> > The global variable is expected to be set by userspace per device
> > before opening, the particular uio device. For a particular Hyper-v
> > device this value be same, and once device is open the ring buffer is
> > allocated and there won't be any impact afterwards changing it. I can
> elaborate more of this in sysfs documentation.
>=20
> That's totally confusing, please make this per-device properly, as you wi=
ll find
> out when you try to document it, what you are describing is unlike any ot=
her
> per-device interface we have.

Ok, will make this per device. Thanks.

- Saurabh

>=20
> greg k-h
