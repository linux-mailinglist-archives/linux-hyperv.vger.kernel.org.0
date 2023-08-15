Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497A77CE9C
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Aug 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbjHOPAC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbjHOO7a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 10:59:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200510E9;
        Tue, 15 Aug 2023 07:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INwz8piGOnv/kGN5T5K5Xcbefu0CrACWNwwK/+lg3qzZm/A6dCU7ILF6qNX4oLBQn8wDiSxLCuhvQ9O8jxpFTMG8QZfrBWvZIW0TKfxW3MYmcW1sbvsVkyjsckP0XM0lfegXnb5JNIsVztsmolLz24hSi/VOYzBuqYNuEE5UCJnz5SzqEZ1mTUiwCP6LwrWCl++bR1dQr/mBMRRc9kTfxTvlT+qNs6ADv45dXvMyxxBXRNZp18XFRWyaFl/AsW2sYy93f2NKET4QfpT33TCh/nKEUYNz74jbQsBHzteccU/uYIDosvL34x9C6QY7WpmAzZw+2I7mqOM01QtLwR+vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaKOMtoylcva0+M4lKqdJdxgPI59cv3B9L2tYG2zQag=;
 b=jaj05WnVx5aguz/VkRHWVM0/Ocarv+pznzPBrt/gvRhcth5CBuBo2XOEyYg1RArojvyjuxLpYFxcWSzROTskY1lgFdvBvBUOysLVoQvJAShpPjOI27uTTMOs24+SLqVsprp1G0MN49JAKGGHwK+HxAKd85CJ7C1Sffr1iZJyQJ/TCwvtDdUSABELe757t+DaX+0jtWchnhQYPqU5z6oPg//uo/My+rK6GKsb5eNNBDhhfTV7rJenLoSHw9fmLJpyG6CUwr/pwIqTrYa2VCUFJQPLrKmVhcqitip9l2i+QDEPqf1GjfXEoZ0BunVadnP4k2W/FUwDJx7lG6kCpyYNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaKOMtoylcva0+M4lKqdJdxgPI59cv3B9L2tYG2zQag=;
 b=cf8BmYpghK4StMiIxcGWvsyHt57bSK11WrR5bgfQVLDjjMhdQn2Rzh5Nq9Uu5UxVzn+Tvsr+Ni/MqON010aTqp+Dm2pKMfz/i1ujL0JMEpXRhgaGOTO2vH/uT+LoWodooZhC/KkKReFG/PjeI3UwKrK/0bHM3FL729dS2OjaSlY=
Received: from SEZP153MB0629.APCP153.PROD.OUTLOOK.COM (2603:1096:101:90::9) by
 TY0P153MB0782.APCP153.PROD.OUTLOOK.COM (2603:1096:400:27c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.3; Tue, 15 Aug 2023 14:59:24 +0000
Received: from SEZP153MB0629.APCP153.PROD.OUTLOOK.COM
 ([fe80::3920:b775:216a:6ab]) by SEZP153MB0629.APCP153.PROD.OUTLOOK.COM
 ([fe80::3920:b775:216a:6ab%3]) with mapi id 15.20.6723.002; Tue, 15 Aug 2023
 14:59:24 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
Thread-Index: AQHZyRSxPGtis/WiUk6q7r4g1TQVD6/fDg0AgAECfbCACjPagIAAAauAgAE3xmA=
Date:   Tue, 15 Aug 2023 14:59:24 +0000
Message-ID: <SEZP153MB0629011E0D51623F00E0B951BE14A@SEZP153MB0629.APCP153.PROD.OUTLOOK.COM>
References: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <PUZP153MB063512844F0E2FB075214C57BE0DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <BYAPR21MB16886B19D5E96933B1E9F6BAD717A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB1688600B746F8BAAB702A019D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688600B746F8BAAB702A019D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee73fe59-7a8a-4e9e-b0b8-3fcc6a8cbf7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-07T16:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZP153MB0629:EE_|TY0P153MB0782:EE_
x-ms-office365-filtering-correlation-id: da3ffdd1-d100-4b79-f2b8-08db9da036b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gX38k/wCIpiH++xSOwcP0FlS6lyQ7nY0P7abtGAidSgd5tFJURIIcVuokwiXBQVMT/QpoPBN842JetFyCykM6pk9xHINQL+W5mRIEjlS9F6KQwZstf9j4AwdH2v/g6Cx+afE8snVPVD4I84gOlOJIiFXrfDSzYm0P22QHPobHmvwHN0BLm7+u4RpKmp+L54NEeeH44koZdlkLsRJ9HHIkwOfjP0VV3Us4t7Gb/jPM3B/A45s0dleeHbXrdEdQpG8X7pHCUFUAY7EqXGaLkeG96ivUjBS/Acq0Ao8EQECLxN4zFcSkuwUnjblOkwELFvhehUHyo6QuCTguzQTfdCsk7aG0aV74DP/gfOLtFWJYH9ze79q3xKg+7dXLXPOP+fTaSNFRy+58CSzk9kcFB7ETh284rPmB56a4LAsyY79P9460hg9e1k2IkNcAweEfdBeZxH0jmGDNwlQYXqlRaQSRk1H9TZ9D9baBXMv8Jqk+Z9uu5c3ZhJYp2vnWfLedOGNocByRL7fckD9p8JWSLpp3Bq5kf1NnmXF4bAf3pG3Z4y1Wv6GAx504RGYyCWeyUKwJBX9J4s6whCOYno37HjQLUEuh7sXK+BY/W/28BBCoY+GvHRnRFva9+JS964TKI07K+Dtqf0a4xMOmoyu6tuml7IrSw/SVoGnJsdysNb2Mt8xFr3G/KdPUw8q60+TR/S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZP153MB0629.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(8990500004)(8676002)(8936002)(66946007)(478600001)(66446008)(76116006)(4326008)(10290500003)(33656002)(86362001)(9686003)(64756008)(66476007)(7696005)(966005)(66556008)(53546011)(110136005)(71200400001)(316002)(122000001)(54906003)(82960400001)(38070700005)(38100700002)(6636002)(82950400001)(6506007)(55016003)(83380400001)(5660300002)(41300700001)(12101799018)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4niyHF1gvaf9zb3+h9X4jo+cgVqH6wWiTADVhPKPm7E13vZ1X3wRPiHu2iXQ?=
 =?us-ascii?Q?2Ndh4OIfbSN9lxi9aSP7b9eRkOa3rb9tURYFa4fQzmkdpr4KqTdV6A4SCD6E?=
 =?us-ascii?Q?wXgE5Cr76ZPyCVUseuEv9PK35xDaPW4CuqKgfUp4r0dFUpsilqWlOg17He7D?=
 =?us-ascii?Q?obc8NWi5wJ1J8dEpMkDZXBxj33LcJPbvElKGdm6bWn7bkQFqorqAWzbu5bWx?=
 =?us-ascii?Q?fywih2Lq5OLvUSiP4C8Ka0ZpDrMcR30PWkv+q/suWUA6zXSkfxBmIZmK9wnv?=
 =?us-ascii?Q?F4uDMpRDgG7Kltc9/6DFc5259pjYG3eXMZOdM4BWan3NVK0pZhZB8oTkPV4G?=
 =?us-ascii?Q?RFxPaw4tMRGW5VgIeCcTxQ0KviYiWGoIxIclBjTRflUueUDz82TU/J+etzZx?=
 =?us-ascii?Q?ZMxjG8F4bD/LnkFdmgOKQTkqcfvtVN8otzYywrL5VnOaI1yB9J/POCe42enb?=
 =?us-ascii?Q?YC6fV9CWGy7VXzGUBjfmi5lLnJ6Zi0lg1hRiHLc6yarUovibuHgOeizJo561?=
 =?us-ascii?Q?Xhu56Q4iGqALgl5N6HuxKEOzee6igJc0h55+SHHpf3G4BBLOyF1ALEtO/p1Q?=
 =?us-ascii?Q?FWXwh8tABBEJzH+QOvzvfJNK4HtzDx98JaCC+RID7PSFIItgEEuFZDmhBnkP?=
 =?us-ascii?Q?TDj/WU5O6TFDP5sLJLwNFHmVxuaQ+jmd9UVPT/Q2861dSm4YEXI7a25N0LU9?=
 =?us-ascii?Q?RfjpzJQBZMvOVtlmMBitv7rhKVY497cUZt1S42Rl/+3CLD/0QRlWBHGicrdK?=
 =?us-ascii?Q?l2ZnILtJrbW/mdMVtP6MOlHLU5668Sp28qosMQqgWbhwUZ2IHb4ai/TFymgw?=
 =?us-ascii?Q?AVcKlyeXX2I5fNjwcoNW2okYnvAJok7zHCXYBKXx1z4jVklQj92FAwuoc5X2?=
 =?us-ascii?Q?KNr9gdrS+aWNlnDKLglGt8PJMCMNQYzIskemTpzHWclJyup3Cv4OtFglLOvi?=
 =?us-ascii?Q?n+23jxGenTMxZDLxMBC7OaL1OLaVHbwAFy8qAU3KYbz+/ZjGxe3wg3FqNEtb?=
 =?us-ascii?Q?8F2wqzONMeerhZFEzeBAKrEl+GJes7L8jgNYv1Hk1M5pVgfst0Yq/DhkrzfJ?=
 =?us-ascii?Q?bvLLMVm4dO0XakEsstIWXKf8bcU89EZIEUTUaMGHOJaUCz5SlBJp/7h4/PI4?=
 =?us-ascii?Q?pPB5M2k/rRos/dPCJ/Dja7I2WL3AKVHoICnfAppzK/GJkZ6VCxKo7YlzC2AQ?=
 =?us-ascii?Q?Az5lbKzZrx0/fHQYvB1nus/FY4RFaUebw8AY6Fs+oqFs1RTCh+R5FDLKai4V?=
 =?us-ascii?Q?Zde3FZqx1SHrM0ymVso7iiRbaojcRTlCQ/wixMAnGuWYRrs215lG2XEjMEpA?=
 =?us-ascii?Q?VKgjVkIN3iOW35i0B+kW7SC8hqkuH+ekPEOIGkzPltv/1Kv/sNXN5/SoxMLa?=
 =?us-ascii?Q?bVjMHL3Zf8IrW59JIp9CoZu0Bp+Nk7DPkOh4/7FJVT3PQIen+wFj7B5gQilw?=
 =?us-ascii?Q?srIOY0qJq+vXV0uqGBI4lbXUiRTi7XVdbCUHxRsi2eeX2sbRr4PGw7ZDykqY?=
 =?us-ascii?Q?U7hu1amLldWwMmbkcikZSXZz1U/RDl6EGex37XCeWUf5zZ5LcDcuZbVGoIS/?=
 =?us-ascii?Q?SvV91dQqb7m8NVqY4oKsK+t3/YOPihG5w1POV1bZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZP153MB0629.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da3ffdd1-d100-4b79-f2b8-08db9da036b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 14:59:24.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVTWgwgvNxsnpurFx9tGvDKhkIrYVEG9fFGt17hKYe5HzcAUfqBsa3TGIRXEs0GsCR58tz+94FVk0fGcZNqM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0P153MB0782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, August 15, 2023 1:46 AM
> To: Michael Kelley (LINUX) <mikelley@microsoft.com>; Saurabh Singh Sengar
> <ssengar@microsoft.com>; Saurabh Sengar <ssengar@linux.microsoft.com>;
> KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with flexibl=
e-
> array member
>=20
> From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Monday,
> August 14, 2023 1:10 PM
> > From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Tuesday,
> > August 8, 2023 2:49 AM
> > >
>=20
> [snip]
>=20
> > >
> > > Thanks for your comment, I wanted to have this discussion.
> > >
> > > Before sending this patch, I was contemplating whether or not to make
> this change.
> > > Through my analysis, I arrived at the conclusion that the initial
> > > validation code wasn't entirely accurate. And with the proposed chang=
es it
> gets more accurate.
> > > IMHO it is more accurate to exclude the size of 'ranges' in the heade=
r.
> > >
> > > With my limited understanding of this driver,  the current "header si=
ze
> validation"
> > > is only to make sure that header is correct. So, that we fetch the
> > > range_cnt and xfer_pageset_id correctly from it. For this to be done
> > > I don't find any reason to include the size of ranges in this check.
> > > With inclusion of ranges we are checking the first 'struct
> > > vmtransfer_page_range' size as well which is not required for fetchin=
g
> above two values.
> > >
> > > Once we have the count of ranges we will anyway check the sanity of
> > > ranges with NETVSC_XFER_HEADER_SIZE. This will check "count * (struct
> vmtransfer_page_range)"
> > > Which is present few lines after.
> > >
> > > For a ranges count =3D 1, I don't see there is any difference between
> > > both the checks as of today.
> > >
> > > Please let me know you opinion if you don't find my explanation
> reasonable.
> > >
> > > I don't see any other place this structure's size change will affect.
> > >
> >
> > Got it.  I have now carefully looked at the netvsc_receive() code
> > myself, and I agree with you.  With the 1 element array, the
> > validation in
> > netvsc_receive() could have generated a false positive if the
> > range_cnt is zero.  But I don't think a zero range_cnt ever happens,
> > so the false positive never happens.  With the change to use a
> > flexible array, the validation is now correct even with a range_cnt of =
zero.
> >
> > Please add a note to the commit message for this patch:  The
> > validation code in the netvsc driver is affected by changing the
> > struct size, but the effects have been examined and have been determine=
d
> to be appropriate.
> >
>=20
> One other thought:  Could this change affect user space DPDK code that is
> processing netvsc packets?

+ Long Li

I am aware that DPDK code uses uio_hv_generic driver to have its own
implementation of userspace netvsc and the changes here are only confined
to kernel's netvsc driver. Thus, I believe this code shouldn't affect anyth=
ing
in userspace netvsc implementation.

I also browsed the DPDK code and found that DPDK has this struct implemente=
d as
struct vmbus_chanpkt_rxbuf and that already has flexible array member.

https://github.com/DPDK/dpdk/blob/v23.07/drivers/bus/vmbus/rte_vmbus_reg.h#=
L182

- Saurabh

>=20
> Michael

