Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50C64FB1DC
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Apr 2022 04:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiDKCeb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 10 Apr 2022 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbiDKCeZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 10 Apr 2022 22:34:25 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0236444;
        Sun, 10 Apr 2022 19:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUJrXk6BsJ9mwCAeVpuiDsr/FBrjuKiVljPvQ9Xb5pRX+vEdSFemKLISSrvg/1PaMm9nkli1s6WMHIkaFpli5veO7PZNg2OKiWq1KoI9van0wmwpGsFbWGbPsXDxn/33XjxEtUifkDO9sV1LYCLYHXrWP6F3QYhGrvJwqDq6W7cV34ybU849qQVFZnqZp4foQMHBA/p2ptvmGfCqJSIvCklgxyU9iemasRRNVSu1hTC2Vr1jhYuDkk84YersExOMoKoEwkP9aPZOL5xoMhR46Pxsxw3fujmBFlc65hjg6Bge8QqhZE6PhYy8PRSLW1MEOGEKgD+0IFlJ8FdPjHZKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRDYps2nEoLZZMBpPe59xrKxErPElSwib9gFdMXaMds=;
 b=LBtkEo/hM9T/WT7qF6k+O8KgIUQVra3PilU4il8zn9a+b4utvEf0tmHaEKFnJ1Fd1ZYljjsXshHdso44FInvtkF3RcPnhhaEj5nrKnOD3Rusb3JeQMOMkPhOvMnys89AjlU5JMwKVc3oXmIBIM2iflfEv0yk7I9lFbyJWxhJsk3NL+f4HygQlKQrpqXrg6cfQkgi6jCSEDUfbDTfAQqkb5JI75lMO5mfD4gPD5viVZ5wgO+QcL1URJZ2I754Di3ji+jCXZ7NJIcGz/n89I/EWqsQJvaW8VepmmUuPmJV4GtPvoff1oOBtg8r16qRV9vlbuYmb0zOsv0EttencEJ7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRDYps2nEoLZZMBpPe59xrKxErPElSwib9gFdMXaMds=;
 b=DqO/a8YjwufWKcbb0GwLvpM9mogIESs0iJFNWdtWOYaLqke/Jg5nzXfnvJhr2QM62PCLvvGiUvfhY00RC9x2Yh8jn03I5vHCBuRzTHbRdf/SO1rebm35d0Js8sHKevYpzoMBXNNrrHr1ax26ExVRGupD3SF/rl4DDCfusUrO7pU=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM4PR21MB3080.namprd21.prod.outlook.com (2603:10b6:8:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6; Mon, 11 Apr
 2022 02:32:00 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%9]) with mapi id 15.20.5186.006; Mon, 11 Apr 2022
 02:32:00 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Topic: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Index: AQHYSjh7yz5y0LU70k+FVkT53LIUc6zmJBNggAAYGICAAAmkYIAANvQAgAOHHNA=
Date:   Mon, 11 Apr 2022 02:31:59 +0000
Message-ID: <PH0PR21MB30250D8A56D544CEDACF9B8ED7EA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-5-parri.andrea@gmail.com>
 <PH0PR21MB3025D745B0F3FA8893B32B39D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220408164717.GA206777@anparri>
 <PH0PR21MB30258AE4C3CD9674E953C765D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220408203828.GA305168@anparri>
In-Reply-To: <20220408203828.GA305168@anparri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94e99b88-01aa-4ffa-a7f5-117147401bd4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-11T02:30:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28935f7f-586c-4fe0-678e-08da1b63749a
x-ms-traffictypediagnostic: DM4PR21MB3080:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM4PR21MB3080FC06902A2FC2310CBD62D7EA9@DM4PR21MB3080.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6AN8+ulP+PtkjlXmimzykQlREUClMn/1g84uswUoXXOf/TMrvbvgMA2UGOx/Ns7su71YO0OkVOJ/x0m2sXXvuF3J3a22Tz1f0VRWhJEnmOvfsGWdBBTWVcAUBG7S67BSyzl2J1+0Rx05tFHAVR1MVASYbnghM8MrmkxqKgFql45MS9u1z6z+kq3stkBiXruCk0TN6zJIYB1MuPP8sedLR9dKj+d4pBV19QIpdElAK8+QIbJ45c00k0GRvQyCmKN03qoLsPEWEiDpUj/C0G7IRp36+Ba9uSX2aQnBK79LHJy1Kph9jLuJJwMZMmJfnlaekZY1/Pe1T5MeG7F8MCVeMlCSdLx1wlGuKdnS3j0E30jbE82RQGHuwcXCq2XOdkbpkSwvrGvACIwRRJHjNXJmkWhtTlIQUbH6G8iHOgvJK30ZuHfeq5XYuYGtYRP3RsjHhj8WTp47hVM3c0u5X4H9Cepa57RWkc875X8owImxBdBoCkL6ghsaG4SCjZnaqr4X2+NaKoUk22AGnWuiDIofNU2DS7JOG0YFxVu/uB9rXc3LIH3o3kHc+Z7agtc5v8nS1Mmp+XgZ53s/fIaVwyUrlR8v3jNzOz8E0o6mNL6tFWdyhlmAZSrXI9taJ8MzZlNi4myKnCqa3w3Y2CE7279BA9SoTgH7dMI9ABPsgeZtE3ZtACBeLIGbI5UzlmyckSiHXI30AScK47gEBTKkIZyNCQmPDtndzAaRe0nc9uwVWCY+3VCBrpWX/Eo78S2T4Yz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(316002)(26005)(82950400001)(71200400001)(186003)(9686003)(6506007)(8990500004)(122000001)(83380400001)(33656002)(508600001)(54906003)(6916009)(52536014)(8936002)(5660300002)(4326008)(66476007)(66446008)(8676002)(66556008)(76116006)(2906002)(64756008)(86362001)(66946007)(7696005)(55016003)(38070700005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mu5fInt7lbvYmZ/kKT0o3IY/7g12xixBEp1gNfSutYs8flfp685WqgkW0vKl?=
 =?us-ascii?Q?n1POkl5bIj6T4w1twpimnGcLcyyfTnPyFeOTyXBdFYVXkwr/kLoIwGUEcNcR?=
 =?us-ascii?Q?vrcJp0OQ4B99zdVX8+kx9GzwxGzf+rfXD4UT8qgO3JWYsJhvTkBhnKRg7qXa?=
 =?us-ascii?Q?z2h1s3nuFJXapxMN7wJ3NqD+nZl1ruTMzJoD4YXhlMhaJlshC1Jz3S2c2You?=
 =?us-ascii?Q?2r4XUjYDZ90dcH7EvaCirLayIn/yYhLUq0IMCY12OndlON2AC2Go9YIkseeZ?=
 =?us-ascii?Q?Nu3N87juW3pZAD4QhS0P2PGId4i3WYN6aup5goKQeS9XKlSa8Rj1EmbjthGR?=
 =?us-ascii?Q?dPd+bk0ejGP1rz0iaxwDwAWzmhu1rwHlz8hSPfo0Zv0BUN6Sq6LQVmM8zGB4?=
 =?us-ascii?Q?+Y0PKlWQ2BDQyQ258XuFyDDEyJryIXK8JE/h6+4e1Y1izy83gwuoYekPME4d?=
 =?us-ascii?Q?30EkrdHnoUFH6TEBKFJNb8PqqEsdi79AFa6eadUjIEEuauSvkz+FlBpy2tYk?=
 =?us-ascii?Q?LZQYAb0154hX7EShVJXnDX9Kt2MZ/+nSBUr9jen+kthMfPhCes3k6D23zbiV?=
 =?us-ascii?Q?i9/c5Vhj2saC3V3pHEMZh9zB5wml4KfupARqE8XkV6jk502PfqZuEXSUYleB?=
 =?us-ascii?Q?sVHoULcUDQ3SUSVU6yT3xCyTDOcCnh53d+jbl5957/3/LDPqK7u2NvvUhYHN?=
 =?us-ascii?Q?kxwiGL0/kXP0x09EmgUrU+Udtm2tTCYFjkL4MBUJIV1EjUXEOrgn8QDP4WPq?=
 =?us-ascii?Q?tCS1Y/7oaZvOCevknGzmC/LGjXLS5bLGtDcIv9J7XQLIS4ElgiwGvvF2278j?=
 =?us-ascii?Q?wlB+3cVuL9945YRs9LF9c/WYesx3XgqjEwgnzXAhmATthguHAC6GerXhtk40?=
 =?us-ascii?Q?V9yBH/RHl0MC1EDDK+JKtIz5C5bHtg0KiuEv3SZCWmWyRLcXJJ7uF2BKvPos?=
 =?us-ascii?Q?x2esLGYwSq0r3BC5LqxcQ5ghnyF1FpXrom9WRxplYqmSSJ3h5+rj9Cz0q+r2?=
 =?us-ascii?Q?e0KM2XxviHkS1keE1DsvFut9rgGovGXQ6IQnRZz7531x7vzatKDSb2AFSsqV?=
 =?us-ascii?Q?UJglpEsuKM5C6QCPf4KSmGskzlgPnrb0Rn38pLnq43ONGq+WMz2CYVHPwLJw?=
 =?us-ascii?Q?y+26nszBFKsqJXUyr86yK9eMip8yZ2nE9Ykk0ooTODmhvJEzz8/+6lm2Kor1?=
 =?us-ascii?Q?pvXlq6ajSV7dQGtgLrPsp2SbOUj4lzUr0W6zsnKWHE7Fzzsq+bT8xPDaoTgu?=
 =?us-ascii?Q?vCsyVGVrgvRGt60R17KvEHMzNHKiTdzZakfaRvfOYzIo6Rr44XUivJRnCWeo?=
 =?us-ascii?Q?H2wawjcaU9s+YX1g77BNqrukucDDa+ofn8sW4FvcpmAQw2bfwvQmKYe3XX+i?=
 =?us-ascii?Q?MYOXF+OorzJTXnbnL/j8HnL/CRooJ6HYYQLddth5iWsr33hL6VN8muHB6tF7?=
 =?us-ascii?Q?kDEK82g/YA7W4sFP6Zd78oliMmGSv84QDQtoOCmmDLeIBFiryq+4fDFvzZ51?=
 =?us-ascii?Q?py4lk4RySd+vrnnIvA28lwAQaPpQH0QlMqCIcEuZdFDr0xBmkgKrhh+8dlWP?=
 =?us-ascii?Q?CvSPSse6NqtnCKa63vTlfR3gb56EC4NlVaoqj6Pu53DZI1bSELGyeDXTqMoe?=
 =?us-ascii?Q?S/34Z2oTY/dmK96eTRbyGgpw/+2pt8F2JUS6rswMZ52jDds/daXa4YPmc9yO?=
 =?us-ascii?Q?4rkzrRTY0PviCxOGq4mvLJSxs5cCAUHH08I2O5uct9RMMsT29Aqz8VdbzBeV?=
 =?us-ascii?Q?wz/bphSC7ZevgWqKSKoy8ugnFUgqnXs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28935f7f-586c-4fe0-678e-08da1b63749a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 02:31:59.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ocab127nga/KD68OAJ1AuFqO82B901Mhfy2OH0HkwhKKbA2feIj0aUom7sMYD4hzvZ2bxWfazmMMzosx8AmwRTXXT024QK3yK5lDgdj/U3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3080
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Friday, April 8, 2022 1:3=
8 PM
>=20
> > > > In the case where a specific match is required, and trans_id is
> > > > valid but the addr's do not match, it looks like this function will
> > > > return the addr that didn't match, without removing the entry.
> > >
> > > Yes, that is consistent with the description on vmbus_request_addr_ma=
tch():
> > >
> > >   Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR=
 if
> > >   @trans_id is not contained in the requestor.
> > >
> > >
> > > > Shouldn't it return VMBUS_RQST_ERROR in that case?
> > >
> > > Can certainly be done, although I'm not sure to follow your concerns.=
  Can
> > > you elaborate?
> > >
> >
> > Having the function return "success" when it failed to match is unexpec=
ted
> > for me.  There's only one invocation where we care about matching
> > (in hv_compose_msi_msg).  In that invocation the purpose for matching i=
s to
> > not remove the wrong entry, and the return value is ignored.  So I thin=
k
> > it all works correctly.
>=20
> You're reading it wrongly: the point is that there's nothing wrong in *no=
t
> removing the "wrong entry" (or in failing to match).  In the mentioned us=
e,
> that means the channel callback has already processed "our" request, and
> that we don't have to worry about the ID.  (Otherwise, i.e. if we do matc=
h,
> the callback will eventually scream "Invalid transaction".)
>=20
>=20
> > Just thinking out loud, maybe vmbus_request_addr_match() should be
> > renamed to vmbus_request_addr_remove(), and not have a return value?
>=20
> Mmh.  We have vmbus_request_addr() that (always) removes the ID; it seems
> a _remove() would just add to the confusion.  And removing the return val=
ue
> would mean duplicating most of vmbus_request_addr() in the "new" function=
.
> So, I'm not convinced that's the right thing to do.  I'm inclined to leav=
e
> this patch as is (and, as usual, happy to be proven wrong).
>=20

I'll defer to your judgment.  I don't see anything that broken with the
patch as written, so I can live with it as is.

Michael
