Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7063D01F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGTSMT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 14:12:19 -0400
Received: from mail-bn7nam10on2128.outbound.protection.outlook.com ([40.107.92.128]:57856
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhGTSMO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 14:12:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5oduukRL9uLahN2qwEsXhLcPXePx9jWy8+CePEaSi7C/24ZGkaKKR70/oGAjs55eyfC+AmnCwKpDDy1jBzkZ3kboSgStWBaUkspxCgeho7f4EG3KOXSYPVCtsoN7NHqcjWrrPpfhvwW21fYpBz4epQjRYVWEmbqqugR1h79JlYCG/6ug69CTCKGpKT4dfs54OOfB9x5e7Pyu+/fFjwyuQw+zuUau/9z6AUe6g6oXqgqCJI6E7tumqUwecN8kTiW7tx79T1q02MtXedsdYfClIc8LhmsqNxRhOHNy0yw4r1GJIOY2gDtWj6+IqD5ErBFeEAMhMgBP3ZDamueM+6lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk+tOTIno6t9W4vOXuxlXJC+UQQtdp2aLrVz43jXh84=;
 b=POfe3IgvRs4IBxZIJ62732L3Qid7grKV6VjRMTQYYBDu53+8+DIJHRjXDBr0L6NwH2dh2cNSTvfTYWGRyIR5rVRmtzelQ1+UJx83sE9RENi+HyF86wSNSPKVPUx87g0j/L3WxgKgG60ZjKLG+/wGlPc3Eiu8IAns2Nhy/ohgzLxGI7hwtq1EA+ywNNCY3RjxctOgzA7lKjcx3wX+HBtHSKPDPdm73Y6qDmkAyikMKXejdU1/Xq9GzfMm5C0QNgDE6VBG3pW5ChgguwvRSpgI+1SZnBBk8G1NvxaNXkrr2ili2/2LWq+jZyQzBx1YQA1dDJX9IUrVdVJm0kAk3i7gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk+tOTIno6t9W4vOXuxlXJC+UQQtdp2aLrVz43jXh84=;
 b=I+VhVVI2SG3oCKFEBT9XKoaPqa9sch3c/d4deCVfW+MNPrVwmMxgKfrmCOH31hq4aSPbRsQhSC23r5fv/EShT9Sx8fiOx7zTrCW1hvhkQHqif8w7hEg5gKzqXXzy2WIxTc+BGsNM5E/acO1KgkbPvgwdtl11+0ex8ijgLCPQEY8=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1888.namprd21.prod.outlook.com (2603:10b6:a03:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.0; Tue, 20 Jul
 2021 18:52:50 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07%8]) with mapi id 15.20.4373.006; Tue, 20 Jul 2021
 18:52:50 +0000
From:   Long Li <longli@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Topic: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Index: AQHXfRe50VdmS4suz0yD44Lpyf2vv6tLR9UAgAAXUgCAAA60sIAAjBwAgAAjOeCAAA85gIAABhSA
Date:   Tue, 20 Jul 2021 18:52:49 +0000
Message-ID: <BY5PR21MB1506BE2D80B696923486D191CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
 <YPZmtOmpK6+znL0I@infradead.org>
 <DM6PR21MB15138B5D5C8647C92EA6AB99CEE29@DM6PR21MB1513.namprd21.prod.outlook.com>
 <115d864c-46c2-2bc8-c392-fd63d34c9ed0@acm.org>
 <BY5PR21MB1506822C71ED70366E1B1BCBCEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YPcS41v9x6+VlQXt@kroah.com>
In-Reply-To: <YPcS41v9x6+VlQXt@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1bcec51-cc67-40d1-9311-4cdaf36cb9f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T18:37:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c60f56e4-4962-4972-eaf4-08d94baf9292
x-ms-traffictypediagnostic: SJ0PR21MB1888:
x-microsoft-antispam-prvs: <SJ0PR21MB188816BB2238B44968713B0CCEE29@SJ0PR21MB1888.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lto4dMFpoxHv5AeUgj7o68OFws+Lh1vbLhgb0q/bOxUJi/HP0jwmaoFw+r8auNqw4V/qb+rz9t0gDPbazMiPBUaeOIa4Tbe0+qvHyGdFV3a2Qz6dRmzpG/AML6Vw4rMNJjTAmCH51J386W6e8Jb8nQmU32iiOvFh05vTpNr/ODSIWRvKbentyB3109cbEr9myZLK+FNDeSuEndTZNtZKzoKB5XNCJrRYehUfsuCFJ39UQDMycs1R5yU0HYHkTmUscPs6rXA4TirY9ifUQrNuQxD5Tv83NeqEoluoo+YELr2ZQ3rxp4iY7ywuJUitxSELkgm7zpyk9suvc3IwRLorjmrFWrwwB4UJBWHb38ygChq9/HUG4VP2ZHwgH3oBbw41AjtBU6Jhd8wIRv+/eU/XGFePVIcJo0Xxu24LJMW+Ktuqp4hg1AsC+kgkjkPgxHpAhte+v4zD9D97jUtvfMstLMmsy/K6HbePU00JfpoZe3e4JIANMY/VnH9dgM5VB6fzAjXgsD6yMlyqS3lsdrpOoO0GEHbb4sU4m9mKCA/+2vZUL2oyeFAZ8Dt21ufcpAjAu87aL8uqjJEKJupUaAy9oeZ2WeOQKFyue0k/WtT2OOY0unYkW5vshaEu04lDK88D3h0y+oxr9oKOqkr0m8ZMVdMNuuTY6qaiSWCeguMPcPRtHKjmNHAcbeopLy4DWSBE/1/cMpta7EU96jSUyxX3pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(26005)(7696005)(122000001)(9686003)(82950400001)(2906002)(38100700002)(186003)(4326008)(64756008)(66446008)(54906003)(8676002)(66476007)(316002)(8936002)(66556008)(8990500004)(71200400001)(66946007)(86362001)(10290500003)(82960400001)(52536014)(508600001)(83380400001)(33656002)(6506007)(53546011)(6916009)(5660300002)(76116006)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12HhgzYsRJvhtr/ANIN1BkpQ0i55TJ4JYEoAgVD0JtxJvFGFeLY6QouLAyiP?=
 =?us-ascii?Q?dUt4iERRcS0jdFxq/yUXBsHZbJCWZx67LeVG/hT7Aw3vD153xZTeLj91SJmk?=
 =?us-ascii?Q?j2xS2zfrruafyic1u8YV6gf140ITNzWeiqt0zS9gjCclB2cOWedNTMnXZ6P0?=
 =?us-ascii?Q?1bZfPltFdtHPQ7t4XxQnKn6I+2g3KZXgSIu7vEqoezWZmhV/LaDX6fcGUSrT?=
 =?us-ascii?Q?HTu/Sj2BPM3FXybvbL3ajBWukr4G5TWRy5oMcahGsV9slamlF4m5t8Qkom0P?=
 =?us-ascii?Q?Wq1VuCGCNGuEr0dFr5O3vlfuMjeVN2HErqXCGsb2MOIwnTHrWS1xk5W2cjvn?=
 =?us-ascii?Q?HMYDj7L4S0WJCpOa+waoroPmoni/JYVLIEv8FwuYflGwTYMpMqNveaDjh36o?=
 =?us-ascii?Q?r6si8mO3+5mbtGzFh4RXh8DFnF2iCzzgs6Ulkivuyt2pEokOBjGBH59U6xGd?=
 =?us-ascii?Q?QFQu7+MUuatQaV03sqhnF0j+7G4oEy2npzIwB0mzVTdOIyXcO6UC9QrNmpZb?=
 =?us-ascii?Q?FAKhMPvzXVWNhAplpI0RDR9xkdT1st9ihXaSnrhlNilhWjsZoBxxrjuBRAHD?=
 =?us-ascii?Q?tvu6sWk7GngKoEgoBdyo6cnBmSZg7tSS6uUzh5lWNKbaQdKApV3whJ3KrkNu?=
 =?us-ascii?Q?W3mXgAqq0uehOG2N5VxYbIEtwLoL9JtpN+9aKJ2DvpPN8ULhJGVVrAN+GsON?=
 =?us-ascii?Q?gQEMmGUL71jKE2wawL/Vqcmq6uELVZfwMB1Ak84jhFT3gL2yp6w9dV3m1pI5?=
 =?us-ascii?Q?8JcgfGJYmcwx16QExyMv1ALNCpK81J5+ntW1Sa8ksD+JitqQY/zPSDlCy7JJ?=
 =?us-ascii?Q?TKYUPw6GZghdO/EtPQdnS9dUUTIj9xY9L42nvhQqccDBNjUf9DmMlJKX9+DA?=
 =?us-ascii?Q?8mrWMLJxWZfioWiy5d4Vn0w+ffXQO+z6mLXXS69BTxs9ga6G86OnCBvwLWuB?=
 =?us-ascii?Q?QJIsq4VAWmwWr94bWBhuTkdNgbJsyIMZCzvntV4g0uzzNgAxb0hbMbPA0yKG?=
 =?us-ascii?Q?S+B4VsyF4CuzXMKGmvtXebl6zhx12c0Sq4hNSIMGzaL9u7swo2gmtdElGhfI?=
 =?us-ascii?Q?TmTkO9Pto+qZ35mq+Q4CtoyxQT4QVuQKMvBLuJ2WKxcbTVklCWBkV/zVfb3p?=
 =?us-ascii?Q?yJtaM0sHR5rrivLT116qX/JvELjIoNbqjEgxCrSryN1t7nrk/mWbyUfgJU/l?=
 =?us-ascii?Q?cXjp/di8QpJ5qmSjYPZ/loIuQw7E1uuip8W15Yb5D8dlW8lafYKmPysYNNZV?=
 =?us-ascii?Q?WawIGV1ej9Oqg31z6UVE7F0b2xxnshm9z/sCfiwu/THKZykygb0B2p94Qkqu?=
 =?us-ascii?Q?Dnw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60f56e4-4962-4972-eaf4-08d94baf9292
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 18:52:49.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH03CdXmxEey8G07vqKuNyKBzERSy/oy75alAS/J1UMQ2GfB+9PcLjZiTQmg2bjU09AiFkUzODTKQuLjLjYAow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1888
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob
>=20
> On Tue, Jul 20, 2021 at 05:33:47PM +0000, Long Li wrote:
> > > Subject: Re: [Patch v4 0/3] Introduce a driver to support host
> > > accelerated access to Microsoft Azure Blob
> > >
> > > On 7/20/21 12:05 AM, Long Li wrote:
> > > >> Subject: Re: [Patch v4 0/3] Introduce a driver to support host
> > > >> accelerated access to Microsoft Azure Blob
> > > >>
> > > >> On Mon, Jul 19, 2021 at 09:37:56PM -0700, Bart Van Assche wrote:
> > > >>> such that this object storage driver can be implemented as a
> > > >>> user-space library instead of as a kernel driver? As you may
> > > >>> know vfio users can either use eventfds for completion notificati=
ons
> or polling.
> > > >>> An interface like io_uring can be built easily on top of vfio.
> > > >>
> > > >> Yes.  Similar to say the NVMe K/V command set this does not look
> > > >> like a candidate for a kernel driver.
> > > >
> > > > The driver is modeled to support multiple processes/users over a
> > > > VMBUS channel. I don't see a way that this can be implemented
> through VFIO?
> > > >
> > > > Even if it can be done, this exposes a security risk as the same
> > > > VMBUS channel is shared by multiple processes in user-mode.
> > >
> > > Sharing a VMBUS channel among processes is not necessary. I propose
> > > to assign one VMBUS channel to each process and to multiplex I/O
> > > submitted to channels associated with the same blob storage object
> > > inside e.g. the hypervisor. This is not a new idea. In the NVMe
> > > specification there is a diagram that shows that multiple NVMe
> > > controllers can provide access to the same NVMe namespace. See also
> > > diagram "Figure 416: NVM Subsystem with Three I/O Controllers" in
> version 1.4 of the NVMe specification.
> > >
> > > Bart.
> >
> > Currently, the Hyper-V is not designed to have one VMBUS channel for
> each process.
>=20
> So it's a slow interface :(
>=20
> > In Hyper-V, a channel is offered from the host to the guest VM. The
> > host doesn't know in advance how many processes are going to use this
> > service so it can't offer those channels in advance. There is no
> > mechanism to offer dynamic per-process allocated channels based on
> guest needs. Some devices (e.g.
> > network and storage) use multiple channels for scalability but they
> > are not for serving individual processes.
> >
> > Assigning one VMBUS channel per process needs significant change on the
> Hyper-V side.
>=20
> What is the throughput of a single channel as-is?  You provided no
> benchmarks or numbers at all in this patchset which would justify this ne=
w
> kernel driver :(

Test data shows a single channel is not a limitation of the target workload=
.
The VSP/VSC protocol is designed to avoid data copy as much as possible.
Being a VMBUS device, the Hyper-V is capable of allocating multiple channel=
s
on different CPUs if a single channel proves to be a bottleneck.=20

Preliminary test results show the performance increase of up to 30% in data
center environment, while at the same time reducing the number of servers
and CPUs serving Blob requests, as compared to going through the complete
HTTP stack. This also enables the use of transport technology directly to b=
ackend
server that are not available to VMs (for example RDMA transport) due to se=
curity reasons.

Long

>=20
> thanks,
>=20
> greg k-h
