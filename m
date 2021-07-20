Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC463CF503
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbhGTGZI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 02:25:08 -0400
Received: from mail-mw2nam10on2125.outbound.protection.outlook.com ([40.107.94.125]:21888
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237981AbhGTGZA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 02:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHmEbzF2EMhQq3Io2KTH/12NIT0lgp25+rGbOydL24U/bjyig1FMbSaO7G8rmFBzoO3wH33KwjDOWpfwD/xjkQIYKMKvrAj6F8ElaTuVPC5Qw9mvk2YTbt7URZgPn49omu9Q1U4M4ZbSwD5qnZEi/6j75hGz0f51Hb7qLtvzcUhN2VJuBfW3CmjTftbFhe5CwXfrDPhnw33NZM2vp78OlhPUIoRJIxEd+QddQQBL1hFR/iOkTdcL/RZcMKgTCon6mYKrpVxQK0oTEyRSBHvesXWFCp4JkvYzjaUJkREk1ljrSH391dfvEG80u1kjgWpwRAaa2HPpRThWJftXXvdSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCitc+xRsANd9vgwMoB3PGtMQJrgRlmI7FXXfnQi2uE=;
 b=nAthlNBL4pxsWs9ap8Qxk0cUiFP8SIzxm8Wrg5qemJskcsbzr4h4pEtg1C05Xwnx7QieCJA6sXHQYj3kUrrK0NyKBUET6wSY5JS96WhQEmRGzjhbTEZhdEUnfPt6UwCW4n2KhcCgOrUnIKcuaxNpHmZi2RIyhUXFiD3+qz9rVH/OUR3i1Mq3g+8zJCT+nX7vslnUOxw4Jj4lyQ6O6gUuLJCoti3FAYmJiDEZf5ZiIM+2hAOG7ojySpMdf5lOlBAqsT21bjFwHYTD59pjbUCzK88iy/tPk/BHRVm9/v4Cm4wXPE/kN0CArnVVYk1gFxaXi7LBgs3yrfSx8Dz5lqQk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCitc+xRsANd9vgwMoB3PGtMQJrgRlmI7FXXfnQi2uE=;
 b=Hhn0w26TYxROgX4raHimazHdHgi2JqsKa2yJr5hkLnGRYnFp/SXoHpAz/Q6EmrV4QHn3LPTfZleR0212oiavDqhmUaWsvUpkcb+ni38Q1djX0RFxGOcgRuSWyi6M1T8VlrqPlcEBPPS9kT+5PFsqTYMFEXaHc8PDIh9Mj0kZ4KQ=
Received: from DM6PR21MB1513.namprd21.prod.outlook.com (2603:10b6:5:25c::19)
 by DM5PR2101MB0901.namprd21.prod.outlook.com (2603:10b6:4:a7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.1; Tue, 20 Jul
 2021 07:05:37 +0000
Received: from DM6PR21MB1513.namprd21.prod.outlook.com
 ([fe80::c966:fc21:5b80:665f]) by DM6PR21MB1513.namprd21.prod.outlook.com
 ([fe80::c966:fc21:5b80:665f%8]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 07:05:37 +0000
From:   Long Li <longli@microsoft.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Topic: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Index: AQHXfRe50VdmS4suz0yD44Lpyf2vv6tLR9UAgAAXUgCAAA60sA==
Date:   Tue, 20 Jul 2021 07:05:37 +0000
Message-ID: <DM6PR21MB15138B5D5C8647C92EA6AB99CEE29@DM6PR21MB1513.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
 <YPZmtOmpK6+znL0I@infradead.org>
In-Reply-To: <YPZmtOmpK6+znL0I@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5371eef0-9524-4265-8efd-e30216c7dfb2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T06:54:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dc774b8-523f-42cc-6ae0-08d94b4cc6b7
x-ms-traffictypediagnostic: DM5PR2101MB0901:
x-microsoft-antispam-prvs: <DM5PR2101MB090189D93FEADA46DC6552EFCEE29@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRg4X1mGI05xKE/XgYajltR/pdUPbHvuhSYNRArmHfgGHZ/JzDb5ho0mW5zChHBpYCviCiWukFzLpamo/8xHUaDDmdGPQNVALkKmYikYimlc0jsS6Q2lELqSuDKA0MJ6swWhXz1405ZrvIZ67i/b05kfYh4H1BB3DmVPe0A56r2h4eWcfx7EswRi3+XFGYP+9cYjhgqh7hPLeEes3Y4b//SAm/zWpTW5L5VpP4HjkOZLNKbbuc2G2IRvRDhH3O1or6F41Z1lwOEn6WcrBl36VLBVDFooyZ7T1Ggt8in/CGpfG2IGvOBuqo7JAtNjMY7k0k5ooGD6XB+iQEWOQLoAWzoE7jyCKynB1amzonJVgEmELFqEMSG9gpjHAK/aV3d9aRtWFniaYnD3GnxIimQa3u311JH3emRkhF4ZW+B+vOM8jqat7k62rjuNoGeO8c0H4hVFJdlKZenycnNTFVMRQwcOkqsOlKXAPma7Uklesf7FLT6cEb2yZAx4ccie6SZgAqJW6sAEep0ryU7tHAVaTdaHWFjUWHA2DywDbZOj5WSoCDCSx2frwMFr5lWHkcgqONGDqFzbEFpnn1DI9TKPKtAClThyE91bg+uwWWRQi1tVuEFcUJoNYE9vz5dZwzm2YqV3R7eXCqC7TDVxZjlJh4rMGHjOteJPmghWszAGRPXcTmCWAEgB1ATAUvnfqXtzTzrM2xKYkRVoir/kT8YjTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1513.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(82960400001)(9686003)(8676002)(316002)(110136005)(122000001)(64756008)(55016002)(2906002)(33656002)(7696005)(10290500003)(82950400001)(26005)(76116006)(8936002)(83380400001)(5660300002)(54906003)(86362001)(52536014)(38100700002)(4326008)(66946007)(4744005)(71200400001)(66476007)(6506007)(508600001)(186003)(66446008)(66556008)(8990500004)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GFVNwiFzUREXsu2MpSIDlyEJmFU4AjZfkhhSpoLIFrUO2uDzLHO5lM+OyhS4?=
 =?us-ascii?Q?xX4K03ID0T/L8dWUfXQnGQWl6QiYsMtVhs6zkp5FixcAQT6DCRWyc5eTNu6w?=
 =?us-ascii?Q?abLfCBfDRaKBhOfPgYPHezrXL6dEzN32q8XQapABvxjQ70kQxhxsmTYbDzEw?=
 =?us-ascii?Q?yNtUvZZA1vf6PFE8XjxXq6Dl9qmOFnvKVtARq35mgHrZiWmVLKfDRiSAoFe1?=
 =?us-ascii?Q?O+GVv15zmIYXK/zvXnrvnsmo9dxL7TSb25z27w2L7RgOh/9nhKNflhx8Y2Gj?=
 =?us-ascii?Q?6W5IfNnAjNmBiibErDdmWxTwPzXOtOG8vFKlpPxhkJ+RwOHUPftPRPY14vBG?=
 =?us-ascii?Q?0A1AUUltnULAYUm90ge3pGHJJOGkHzyXS3QFNo7eENJDzjteFuFM82J3VDkv?=
 =?us-ascii?Q?O4DmV5BOflUzlfafJK9a9qhggrmAfmBqZj6fyP6w/gSfe28r4zGvFdSBBH4e?=
 =?us-ascii?Q?JZ+6ptmfOed0P1VQ4+v77UcCPAfe3k3vrQEnaoJoT+pBsJJTyrjwee99j1Hq?=
 =?us-ascii?Q?hE3itQNyEBhOg5sqqJ9HTmyMydWxozd1XueOnJ37yjepeJoOSKzndM6tJtR8?=
 =?us-ascii?Q?cXcuugclKtDJjZIFHIdibdSAxd/RvCMm072ElFmTYDRSL0MXyhWSRSdZjyWe?=
 =?us-ascii?Q?OGpKv9EDItXq6FIVgFpoXnyKohX/HrQzApqKy1HdO+lWIrZ7hMHZ/LRNCq67?=
 =?us-ascii?Q?q+mxgksAVCFvZA5Nx6nQAc03+EkTuJNxvl8kuz/PgwQzWys+Y0XNlSsDGM4S?=
 =?us-ascii?Q?ATX8bL2Y0XheBS5R1AiyCHnpRDEWmd61FSDAtgHUq9tFrvNIXIF6opIl9k++?=
 =?us-ascii?Q?l3a6hNkemQu9xHFDqW3qBAtbcGZ4fPSYiFkoc6EU+Rdp34A441s1eteAgeZC?=
 =?us-ascii?Q?sfRaCN7RK42djJOWoL335559VA730AP3o04Do/8baVzM4zkcLj8gwR6+GClJ?=
 =?us-ascii?Q?k4syC+2AR867eRuUhzoMZ/wuV0XWKX3hL4nhPqEUSDpRlV51dQVZzlTQZW9L?=
 =?us-ascii?Q?QS0wRT4/gmRqRCDF0vxR1KGPJKPRCHHfMVa391djvxkqLbiWdDIhKctic3x6?=
 =?us-ascii?Q?AoOdYHdhCDt0+nuTZ7nByJTcgLO7eSjsGNoTSF2jAmZ+qxMbdZuocW9UxGZz?=
 =?us-ascii?Q?v2NWwBLWWr4K8CgWBpcSrva0RaA7N2nRtTCNa5BJ651qsBRLNeM9OspgVWOD?=
 =?us-ascii?Q?1A0TUwpzd79gCAywKCBygU/ls5C4kmqcFj0B19M7raY5OuGuejW9yUZzjo8w?=
 =?us-ascii?Q?pHBecYq/0jgWG4dFkpFd4e7Hlsd2rH+fxur00s/F/jZaRgzRQv8Bug0h/Unj?=
 =?us-ascii?Q?0sw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1513.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc774b8-523f-42cc-6ae0-08d94b4cc6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 07:05:37.2186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWLvwDHheD0nY7XpbEmLbI/l5VwUDWOF7YQXfjpjLcavBHJX3UBrcIIA/9BAZADCLLIhj7+SFF/QZvX8oudSWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob
>=20
> On Mon, Jul 19, 2021 at 09:37:56PM -0700, Bart Van Assche wrote:
> > such that this object storage driver can be implemented as a
> > user-space library instead of as a kernel driver? As you may know vfio
> > users can either use eventfds for completion notifications or polling.
> > An interface like io_uring can be built easily on top of vfio.
>=20
> Yes.  Similar to say the NVMe K/V command set this does not look like a
> candidate for a kernel driver.

The driver is modeled to support multiple processes/users over a VMBUS
channel. I don't see a way that this can be implemented through VFIO?=20

Even if it can be done, this exposes a security risk as the same VMBUS
channel is shared by multiple processes in user-mode.
