Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B356920A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGFSni (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGFSnh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 14:43:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3A1C92F;
        Wed,  6 Jul 2022 11:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmDfe86JewaQ+jf12kNaTjZCWhHy6S3kvzwBri0LRT0IgeoAfnX0M6p+ESZDzFjM0lQjfCbTSHWLgfJCinVaCE0I6M0GPjmGOB7ihpHBNqM4h7djKwh1VEgEbUOdqzu9P3TByzxgwx/5a1ZOKdwHyG+03dMUpibVnOJYXVT6OTHHGFhZF3jo7ve67lMwvpF6ic36R6IsMzt8LokES0hX0DAavFI5/c6e9Pjl+p4UMUZOPxdzLpgNMdiZiLng19MabALkgEYjjcBqvfk30Dj3rfI1sjzGKTuZYBo/6//yHbVZVQ1gO8pezEYPVEhNBaIWjWxr8Cmwp365RErjVuJl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH3zDGemu+WFhfJ6gI/00pFqtFxhhrABCRF4A2s7/l0=;
 b=MoNAPey3M+IfjGsG6DzgWZWpqRuptUQm2IqlZ1Ue0bf8OcXCD0jy1u4Pd555ScT4+webj3exFA0kMBXg2kC/QHsZV3orjjpGnFhjgS/G0laJW0LeiwEPQ6898qtY445h6Biw3+Im7n3gsTODkDYjilNOxmC1UGLGECzmofFElQyca71GrMDC560kfo87bUHhQ3fLGBmMLJ1xcju1F0dMnqy9+i5T9CdTIMwZnEr4ttraMev76Al6lD1Kkc1h5IQcW4yiImRIhPTub19j7VzTPfUy+HgLC0sHwcT998b/P4b6e3haguxtSOa81yr4Dx08AR+uV8sayJpLwQGsLL0uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH3zDGemu+WFhfJ6gI/00pFqtFxhhrABCRF4A2s7/l0=;
 b=EnOqBs2k7Q/GDn4hhS6J/fc8k5cIHF415xxXF7odKoO5K3Bx8a+aFLISAcUm5U9h0nQiPswMH/yZA4Auwldrid4dTy4PURxbNedvGDlmd9u0RsDSuf4iZ3oqEUgxlx1mBsAJkfzXL+LwLd3YeNZfVAvtysNSomTNZJHx6AyGVwo=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3311.namprd21.prod.outlook.com (2603:10b6:510:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Wed, 6 Jul
 2022 18:43:28 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Wed, 6 Jul 2022
 18:43:28 +0000
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
Subject: RE: [PATCH 0/3] Documentation: hyperv: Add basic info on Hyper-V
 enlightenments
Thread-Topic: [PATCH 0/3] Documentation: hyperv: Add basic info on Hyper-V
 enlightenments
Thread-Index: AQHYkIYtkruTagbkVUicuMDNnrVyxK1xpsGAgAAIlFA=
Date:   Wed, 6 Jul 2022 18:43:28 +0000
Message-ID: <PH0PR21MB30258C6CD682DDC768EE805CD7809@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
 <20220706181207.45jcurksoblsrerq@liuwe-devbox-debian-v2>
In-Reply-To: <20220706181207.45jcurksoblsrerq@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a5eafb9-b4cf-45e6-a300-d8f95dc4ce98;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-06T18:42:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 756c32e7-451b-4be4-a4bf-08da5f7f6afa
x-ms-traffictypediagnostic: PH7PR21MB3311:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/sKYqX+ddUoecVKQCHvDJLO11Dk1+eoflbucDINPYpoKm58Pzf5Nngly54eM9Jo4R8QIFgSCIJuqpg+Ap42292t9TIHaIWLznDROyv/5G+ByRAzyl/Lk+YRkcBdBjEg05Wb8Bvxfx/9PfzW3PilRPw5Z6Yh0jCDhmP2FslxvHeqoff0nLPPAgrPqZ9k+itCnTNDq3ETaSYsvXHoES+mNeia4kgqETwBh+EJbScKvJiVzJqLdZCtdrm3QdjLBj66TFir2DkEyoVFgcTzhYhodivGK8EKbVHzyxVSvCY5EI4WOuaaeI6Urv4sCBOJv3kEn80eD4atQoFwEUxV16s5vtFfHH1edCZlTiHxsVQGgDm2E++LH9HTkdz3U05lsPqJdiCLk3l/f5mjVOwgoWTBW26K1fBRKRc37Yew0GRI5U0rbAdgxuzDpjkfuJtMmLvYXcQEIvoQiQ2emYSZG/dDrBfnouZ9qnobVUNINSvl5Gz3MCLpOrX/w431AGCPbYB0rXzjQWm3Ye6rxZQsDCu/5gi08H88cC76WXGCrHJdf9COQ793zFaN/Ibo73CBJ9amDhKaaOfNOmM5NMlHEQMdKTCtTFN9YSorhSW+g2yWbFELL2LDjSAMkQE9JSwqnYgQthHgAuffC4EyE+SoqXCbhcmzD89wgwB+0LS7LV5HuAK5zqysJ8Qj9KDXobs9p0QMVEgpNJb90njAovKtCaPZfeMqV0pxZcVkuQ95x2HCKW4rcyheCY4i7BffPYSIdjB5HsJWCnnNOnhbl0LMOFNjPLTNabQ+cubMP4CSeXG5cECNEjOfZylgb8Wt+8nY6tJigQlf4gCODV2bD6nmm1ZDQXkWZnch484g8OMWMSCMk7iSEv1inVq8XoM60O8ym4br
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199009)(52536014)(66446008)(316002)(5660300002)(66946007)(86362001)(76116006)(8936002)(38070700005)(66556008)(4326008)(38100700002)(122000001)(82950400001)(66476007)(8676002)(64756008)(2906002)(82960400001)(186003)(7696005)(41300700001)(6506007)(478600001)(10290500003)(6916009)(54906003)(33656002)(8990500004)(26005)(55016003)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VUF3J9BNU8nVpPS6SB0y2tw4r76dGuO2yV5gSwKPpl/S9LnVIjlvgsG1XwfP?=
 =?us-ascii?Q?s5G4X5/JxkPDSgOf+7LfRzfazojJdfrdAz35a/je4mAjTI1Ie5qlteUqca9w?=
 =?us-ascii?Q?q5vVKZ2Eh+DSaWWHADEtlV1wnZO+ufLtVNa2exysRk+CevjzbFUDlGCKxbhO?=
 =?us-ascii?Q?mT7G3vHMBOOxm+qoQ4qWb7a2VU1h1zMGA+BPawID/KdhzMwU6EPkPCyo37Nb?=
 =?us-ascii?Q?AAWCH9pzzFk2+O9DJm5POU+8N5ucKUDdHDIHZHxiw5CoX1ljE+dhULu5FrP8?=
 =?us-ascii?Q?67OiOjsIZWtquoJ2uNsnIjk4gmtk8X0iM5IRritU9s3vPv7AtRGbZm1s7dNU?=
 =?us-ascii?Q?64YrpJzBchlN3xP6sIkmpXYCs0pFC2LJKp8CM9JO3XOzUncYxGo726MEqF3n?=
 =?us-ascii?Q?S1RVXc9MHokKY80xS5Tw0A2dNP8103/XKy/1n/iH2Hw6uR8mqiq2CU91R+u5?=
 =?us-ascii?Q?hqhkzv5d4iIfGu9f/QgSVPrzDVOefKLSkTCbJASYXkXipZ9zJC6KUJ6wDCbY?=
 =?us-ascii?Q?3zHm3NpAZUZrMtz3qcK89uSw+RS2sdsrIECprh4H/mfAytI696dh1AG7BDPy?=
 =?us-ascii?Q?6YLfXWUYnqQ/QJcMGKGlr16oKyJ85RuNminWJjr1jY+Cov783vCPp877gm5L?=
 =?us-ascii?Q?YZOZMZKp8/uTbCqrn0qs587yR+xUFgMi74OeLUPExhnWiIIG/gYnK+Q5IOE9?=
 =?us-ascii?Q?IstWNVExZyqHWZj/giNOHU1C3cmKi7VTRaMCJSerBv7rUngxJaNr/NbJnl7S?=
 =?us-ascii?Q?O7RwA5/xJFPBMrVU98s62JDMsL6PnqvR8bH0DGU3Pc7+Yv5RXEl2fQAe5tMe?=
 =?us-ascii?Q?ZmP5plvnY2ANAyqbcPgp7qFxc9jp6mpe1wwrmoz00NetrHgaKz3mJaCI+x3L?=
 =?us-ascii?Q?pilNw/yLoocUmzuE/G9aqx7CGwDb+yXfpnTFCQfn8nJc3qzDtaHD0qV7R+fy?=
 =?us-ascii?Q?G+S3lgMKlAJLdIUePHJHEGjK7aJ+83pVvlxyAHnDZGRgBhwasG3jzxQ0rl6H?=
 =?us-ascii?Q?EUZybbMRIpHm+ujPxd8dfyuuC+RIDrJzxdpw9GB3bkNtnjJ05DOXAdReYhQH?=
 =?us-ascii?Q?sGK2ZMUVf+GXtOgyiGIh9Z54hUpvOgRV7/6yeAUOqU1vYMmx3TEVecmH5ZbJ?=
 =?us-ascii?Q?JSjPrkAK7kIv7Kt80j1CIomc9Io+kSM77oCbf1PBani+5ju+wL2qKx8nXjVq?=
 =?us-ascii?Q?10a9bpG0NNaB7VMIKQGXCEZVLG+sLrRrZ31ZPeypuPRgh4dNAlnxfVJzYQAD?=
 =?us-ascii?Q?WPlZtmDpEFyrWmiedO1DoQzo5DJentupyDWxHnjNBRAcmrFhbGhoa2wUASAz?=
 =?us-ascii?Q?biXndRTSyDzJGBEhEZ9X7ciBdWWZCMjBIQ0jt8fQuZUqfsl6aI+yE2As4ZTW?=
 =?us-ascii?Q?NBRVy0ag2Wy/RMcvdFv2a0T+fdAr9Z5X1wPdv6f9a4c35nHMostAeYQSNKs2?=
 =?us-ascii?Q?8KfUZar1yJurlNT7bQQNYefFkH7KkCgIa8KjImrdFBsUAnIwS0YXWDdptPi9?=
 =?us-ascii?Q?2si9oT9giwTdbP48lMM+dJ6TLMRhA9p9nuPLn32IGWJvwXtmaNSHn7dpe764?=
 =?us-ascii?Q?xMGG2QkbqhvYD3UZWyL9WaMRw8w1R9e4kCGCBTjXWmSMsZsp/NoTyaMpqaHM?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756c32e7-451b-4be4-a4bf-08da5f7f6afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 18:43:28.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ao0Jr2cLCFtQFCr7nBsIrE6l0YpF9yk368aqT2s3uDi0pb83LRmas4zsod+ESgZJlW/PuqO90EK7lktiaQoWwz7E07YAo94t6hU+R1xiyQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3311
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, July 6, 2022 11:12 AM
>=20
> On Tue, Jul 05, 2022 at 08:43:39AM -0700, Michael Kelley wrote:
> > This documentation is a high level overview to explain the basics
> > of Linux running as a guest on Hyper-V. The intent is to document
> > the forest, not the trees. The Hyper-V Top Level Functional Spec
> > provides conceptual material and API details for the core Hyper-V
> > hypervisor, and this documentation provides additional info on
> > how that functionality is applied to Linux. Also, there's no
> > public documentation on VMbus or the VMbus synthetic devices, so
> > this documentation helps fill that gap at a conceptual level. This
> > documentation is not API-level documentation, which can be seen
> > in the code and associated comments.
> >
> > More topics will be added in future patches, including:
> >
> > * Miscellaneous synthetic devices like KVP, timesync, VSS, etc.
>=20
> There is an UIO driver for Hyper-V. I think that falls under this
> category. Not sure if that's on your radar to cover?
>=20

Good point.  I'll add it to my list. :-)

Michael
