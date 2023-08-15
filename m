Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262577CFF3
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Aug 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjHOQMy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbjHOQMj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 12:12:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2134.outbound.protection.outlook.com [40.107.223.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2051989;
        Tue, 15 Aug 2023 09:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGJ2JDAG2LMiBQwmFKJFbN66irGZZwkkrorSUeLi9RbTcX7tErU+2HDvHhVCq0TYUuvY/9QYRv3tJ2RWKctEW6eJYIGXw8IBO+Rm1vR1TaU/xMpe9zxUpjFf1TvTTsgCpdO2GWUXF9pDGeoVbe8eiQp08eGaT7y2i7FYaDYjexWwSuPwxNEw6d/z8BE1vfADpj5usn5Rsuik9Ww3xJk0/jvlK50FQNb7tkEmTllzEyZf30RUqPvJd9lswxxhsL02OpWL1Q+PDSQT7br/umo8BAKZpVc7N6SUhUjLFqqoS3wte9BS0tL9jTKspIoibgM6VpBnwiB5FxBS/hKRcujRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p0LoikXdoYibW4fNWmDpEKBS0AN/7zBRIegUaY7nWI=;
 b=QWDCO4+7rq0UjJxshXxGgOlgqHq2n0tTBdYaMrqw4OqnyYDElScMOEEnzYpfppqHZMw2Nv5HYGeQM+mVXr1U5nmHLX0b3wYhfncb/gVKO3zRO8LL98Wd5/bbx4Aiyk3p+0uo0zVH8Cz0U4fyHtA3f8Ud5v+6HYnnAl42WXkjhxXfh91KWStwwhTCb34dET1U2NTXawLCdsAyWZsheiBqtjlxwCAxq7aBW4uY9VEeJjX49Wxw/ed7rdP8byPcXOMRlIs1Ozell8pJdMSLvduxpYTTAZ+SFkeX94oS95LPTYNoPpHgG4T7fnBihEVuA2pUQNkqlYCS04J1dL3n40CeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p0LoikXdoYibW4fNWmDpEKBS0AN/7zBRIegUaY7nWI=;
 b=M2wX5D7+7TJZawAWdAl0zVXhJcJhna89zmr5lgnXrfTwgIRdWtdxLkVB8KqW2dpXO2kQL7Eg6s9c4EDi1GeeJH2Sbm525cuCWMTBpDX2kuYj6klvvPh9eMip0OX07llQSNguOq2EVBB11ORAKdOQ6eWyAlK5R3TobBC1FNmkQdU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3311.namprd21.prod.outlook.com (2603:10b6:510:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.10; Tue, 15 Aug
 2023 16:12:34 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Tue, 15 Aug 2023
 16:12:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHZyRTXFp6yedDvhkSOqIWkI+ltNa/fDEuggAEcmgCACheS4IAABMVAgAE6wgCAABO8wA==
Date:   Tue, 15 Aug 2023 16:12:34 +0000
Message-ID: <BYAPR21MB1688F40FA3C2CB6AEC80AC76D714A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <PUZP153MB063512844F0E2FB075214C57BE0DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <BYAPR21MB16886B19D5E96933B1E9F6BAD717A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB1688600B746F8BAAB702A019D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SEZP153MB0629011E0D51623F00E0B951BE14A@SEZP153MB0629.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SEZP153MB0629011E0D51623F00E0B951BE14A@SEZP153MB0629.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee73fe59-7a8a-4e9e-b0b8-3fcc6a8cbf7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-07T16:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3311:EE_
x-ms-office365-filtering-correlation-id: 80f33228-2cbc-47b5-af41-08db9daa6f57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +P2rhn4W+m8YpsD1ly+S5TdE6UTiA8kPyFUHxu0Le+DBrVieOgydYVQUhzAVQY4eP0ir/BOSnZmyHBZ0IhBZbesJV88kq/YC5bEzmkDpZ8qwiFYRB3ct5nvVQ71IUkhvLZrXqr8ZB2N32+d/2B8KqFuNGP2GtNWgYQJKnO7CvUbkTmboYIKamDarbBXXwE1uIYzP9NECTo+IttEDYGJexsGuqW3ZmQc6U0DjFC5f7pdru2iYWma5GFxWkKpPpgtcqENWAW6cSGmvFXcuDJreJMU1vBjKrW4NhWhio3RgzQk3RpPd0YR3x0ah10oj2pcb4u3QD3KiJ4NLhQZ/EGsKF16l8nuXFB//QbhV/hl+mqf8X0rA+SFBmC/HTHxr9kuxVN5y5iDeUYpMccpQ+mS3yJwUjT/d264MHO7/0KyYhEwTgwOEqNLH1roLHofVN8VYn5fHrZ46RE8YWbo+pz5uZJ4GElIDyGGplno6QaXulFozDohGkCZYdANAqjmyba6pebv2dX4RCjTS4LFDLlw9Ax/U5n3c/RYgjQ3Dk3givk/oRNvCX9nn8lwTz4IvdWaeseJUSIao0WsslbkVPA2eDH0xo2EfIKxxHh25+nF/fL44F01SFhwhSHNb2lu5l6s7UE7vtsWS0unE0rDOlTnZ7H1Px/l8hwuMOSoS7bCLbnUbHruv4th///f3NQpRXNqk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(1800799009)(186009)(451199024)(4326008)(316002)(5660300002)(41300700001)(76116006)(64756008)(2906002)(8990500004)(12101799019)(52536014)(66476007)(8676002)(66946007)(6636002)(66446008)(66556008)(8936002)(53546011)(55016003)(26005)(6506007)(38100700002)(122000001)(82950400001)(82960400001)(83380400001)(54906003)(478600001)(38070700005)(33656002)(10290500003)(71200400001)(7696005)(966005)(9686003)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?izAaeHaMxbU6umK90trKS/E8JLUVE5qc9mUbzpwd14sZsh8CTfzg25RtoJpj?=
 =?us-ascii?Q?xA0CRyr5xTF9bVWIvNKbPoV58niZ5LmnNx3h5KigSF8ePqao9t+lbrwQcVn/?=
 =?us-ascii?Q?17X3HCLCBYM4M2xqL6WTtZJDelbZR8liTU99+IffIaRLR9204i15Uwr/fReF?=
 =?us-ascii?Q?MgnCu3aCxarjakO3mP7Y91Gu3zh3Kq9+RzYtOnrVMsMrnO/Qyazl8eTSUUyH?=
 =?us-ascii?Q?H3XHntRFcsKwBYDcyMO60ouh99mK/gw04ZBMhBxZ+MZhPu3YWQ4hMNHw50tU?=
 =?us-ascii?Q?TNl319d6034qsm8kbPe02I2muWQITb7T6smi/OBmGXCFXrNtOSWXe4An5T3e?=
 =?us-ascii?Q?rmr3Z55/wE9xMeEKlpdrJrMNRfItB2BvFqqgwncQaqgvXCpH/7ffiIMnMa3F?=
 =?us-ascii?Q?6podVFOJQ/6U0dyy254OpSWZc4/m8/h4+539LjZ+8cz/ZWbhlXFedNLkjzQF?=
 =?us-ascii?Q?T74vnXz/GV9CpMbUkQ+ZQ8jU/gGltlKCVicTjwHJI7n+oo3C6pDYHvS3+yXg?=
 =?us-ascii?Q?YCMHvwqfWUZIQCaMdCK67y81qKwfZOdIvQr9WkSh6aPSHOz0253gzauVyt3+?=
 =?us-ascii?Q?1qIo60AQSxO96ZRdYmoGrNOHpqnXBWMQntRYqHqfp2pJ7O3hPZScVqG8k1p7?=
 =?us-ascii?Q?lk83sOXHbmlyywdzMfvnuDorTDQZOllSuy4y+M9md9R0WaPQRla8jvhplfYm?=
 =?us-ascii?Q?bRogqlXOqB6b3S5Xh3FW9LmlWHPR8EbTsPtjwWQ0o1j3EJwDFJEHbCt1KcF/?=
 =?us-ascii?Q?Oxjs6IfZQOF0vG4tIOycTkvqUYYbAoYtolAeTdGNo88FiEm6+1UWiOlFyc+J?=
 =?us-ascii?Q?2u2AmUk5JU8VsJlN5Ol/m74kFmKkpHn5TbPpWx7Pu4gSAGdOdvYU8ZYDbviY?=
 =?us-ascii?Q?S+vtau8NpwAPVi8QLj5iNL7Eue5mM7/RstV9X7Y2KCkLDKcioAnLEZnoh/3S?=
 =?us-ascii?Q?ZyzUJfTnaZfh1V0bJWcHYkE4yeEeJ7ZHplQlIIVhmkdK6GVXpyCKLxHt+fxT?=
 =?us-ascii?Q?gbLBSxOw3ylX6uaghjxbzZR2HfA4xSeF79gowKzLmunmE1IC85whqEm+kw40?=
 =?us-ascii?Q?CMlpASJU5EJJHxGv98Gtkzu8NsG5mOZdByrsgfTNp7cye4JvIny8ibzhzECV?=
 =?us-ascii?Q?hZckkIhF2Ekdi596PAin8qUl+YLiQZ/YrYYrDaUHQt78XRMsU6Y2+6f7F+qu?=
 =?us-ascii?Q?T69SoESJXX7Osig1eKErEkYddfyVWMScRT/K6gEC+aFWKAPaN0eCql5SesGk?=
 =?us-ascii?Q?NetJ0osOCmorksJjzzxHlqtQu88UnAsBqB/Dq7Lab/I/Qqtv/qwl4gDqfIh6?=
 =?us-ascii?Q?9MIz3pf5JxQXL5kz72dTgW3CE9DNMjPu/O/lvzC5UXSMoCM5p6MEhyTlt+NB?=
 =?us-ascii?Q?GNDLAjKnOe3ZulzL2pZ09XPeXNh2PuiFvPsXrt+enKhBZWF79BCwA2M7bi7l?=
 =?us-ascii?Q?e7TstrNjfb+O6KqexBHpD5E5ImPTqIhCLg9FmulxlyqULcMOlqWCVbOqAseM?=
 =?us-ascii?Q?SMIbI2oRkZo+foI4VUJw4+qGs/BVqFCS/OOqsQQXqRd7uStDpEsWMMqulSX4?=
 =?us-ascii?Q?9QC1VIcEGMzQzIXGDl7/JN9JQAa4rcvo/yZmUN4i47yaOAzxRjC7Tv1zWW/f?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f33228-2cbc-47b5-af41-08db9daa6f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 16:12:34.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13y2lA3mjsNYu5tcyYg0MmI51c4pr96AlGR7IvxuRlf1WAcz+YHo58DT4aiYXyuJIADfcHDOFoz3RFOWHDIjsiO3YmXEKTPeTie/82QorWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Tuesday, August 15=
, 2023 7:59 AM
>=20
> > -----Original Message-----
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Tuesday, August 15, 2023 1:46 AM
> > To: Michael Kelley (LINUX) <mikelley@microsoft.com>; Saurabh Singh Seng=
ar
> > <ssengar@microsoft.com>; Saurabh Sengar <ssengar@linux.microsoft.com>;
> > KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with flexi=
ble-
> > array member
> >
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Monday,
> > August 14, 2023 1:10 PM
> > > From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Tuesday,
> > > August 8, 2023 2:49 AM
> > > >
> >
> > [snip]
> >
> > > >
> > > > Thanks for your comment, I wanted to have this discussion.
> > > >
> > > > Before sending this patch, I was contemplating whether or not to ma=
ke this change.
> > > > Through my analysis, I arrived at the conclusion that the initial
> > > > validation code wasn't entirely accurate. And with the proposed cha=
nges it gets more accurate.
> > > > IMHO it is more accurate to exclude the size of 'ranges' in the hea=
der.
> > > >
> > > > With my limited understanding of this driver,  the current "header =
size validation"
> > > > is only to make sure that header is correct. So, that we fetch the
> > > > range_cnt and xfer_pageset_id correctly from it. For this to be don=
e
> > > > I don't find any reason to include the size of ranges in this check=
.
> > > > With inclusion of ranges we are checking the first 'struct
> > > > vmtransfer_page_range' size as well which is not required for fetch=
ing above two values.
> > > >
> > > > Once we have the count of ranges we will anyway check the sanity of
> > > > ranges with NETVSC_XFER_HEADER_SIZE. This will check "count * (stru=
ct vmtransfer_page_range)"
> > > > Which is present few lines after.
> > > >
> > > > For a ranges count =3D 1, I don't see there is any difference betwe=
en
> > > > both the checks as of today.
> > > >
> > > > Please let me know you opinion if you don't find my explanation rea=
sonable.
> > > >
> > > > I don't see any other place this structure's size change will affec=
t.
> > > >
> > >
> > > Got it.  I have now carefully looked at the netvsc_receive() code
> > > myself, and I agree with you.  With the 1 element array, the validati=
on in
> > > netvsc_receive() could have generated a false positive if the
> > > range_cnt is zero.  But I don't think a zero range_cnt ever happens,
> > > so the false positive never happens.  With the change to use a
> > > flexible array, the validation is now correct even with a range_cnt o=
f zero.
> > >
> > > Please add a note to the commit message for this patch:  The
> > > validation code in the netvsc driver is affected by changing the
> > > struct size, but the effects have been examined and have been determi=
ned
> > to be appropriate.
> > >
> >
> > One other thought:  Could this change affect user space DPDK code that =
is
> > processing netvsc packets?
>=20
> + Long Li
>=20
> I am aware that DPDK code uses uio_hv_generic driver to have its own
> implementation of userspace netvsc and the changes here are only confined
> to kernel's netvsc driver. Thus, I believe this code shouldn't affect any=
thing
> in userspace netvsc implementation.
>=20
> I also browsed the DPDK code and found that DPDK has this struct implemen=
ted as
> struct vmbus_chanpkt_rxbuf and that already has flexible array member.
>=20
> https://github.com/DPDK/dpdk/blob/v23.07/drivers/bus/vmbus/rte_vmbus_reg.=
h#L182
>=20

Sounds good to me.  Thanks for checking.

Michael
