Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ED042961D
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhJKR5r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 13:57:47 -0400
Received: from mail-oln040093003013.outbound.protection.outlook.com ([40.93.3.13]:56349
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231771AbhJKR5q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 13:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ5BW3Xf120v1fLOaEsax6smRmMqjLGhhCi8O3iQPdC0ExT403Q0McZ2txf05lNpnpAKw8IHbKJzJUHFCV7gHdzeJqnc6SXmmtZED20hm2TJ47IZJDAmjlBPKEl86Iy74cTVcKG9pDIsRohLKWGukGRW7cxh3f0jK26Fkp1/a2ln9ucsqz3iEkL7XoVjHXpUkcpbXqYnbkpx465V4UaMZMCKGTsllEzxl61ShaNyMdRrx8L0dVHyGkxX0iY05YROmSq2rCB5kWL4+ZotLANIRrrTWCSm9TU1pb4gdhfmE9fEtQC0XIYISQViWer7EjGr98XPAODpi7o3plqX1IHTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y57V4ul1//3EuSp9gNdM8d9bfEMLR0C/yla71hWvhk=;
 b=bleo+YO5GDT6QQvcCxqMMO34IM9reZQD5OYIIo+b25Y39o6PHqel3fFeB3NlbjYGbKHsWI7U2+TrPDrxKr6exG6RFnikLsZzn7h8IBIOEzvcyppiW+Y2revKevZZpFMyi13ZxTcJeRcRfqt46GgV67miiVUZj426dZALjiCfEgQ62fx5CHQbqvxBqX58Am0VbPwCVYXtHyf+z2K2aOPJ6hfpFcIY+xZ5A9STvo9QXQT6qfMpkBC0Iclu5LluP+rZsDe3fN3vckZFASzP48tH41CsTBgoQEL6O4M0L50FK/w3WPYZrCocRjsGV6E4aV/mhzRZF0sUVJ/U1+/otPS3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y57V4ul1//3EuSp9gNdM8d9bfEMLR0C/yla71hWvhk=;
 b=JBtUmjV3AfsNmRbdUWA+Tvqr6K07IWScrBrBt9D0u3FYFNpeVoHxYkyZJFNYssAjzbChnC5X/5FDq+zdfNsa4npqGRXqGgkcNt4uHwMBt1crPidsAIoT9taBI2LwT+ieUsYnyrf0FjawyJ5qP8MoGjD2Im0rPTag73UPTUjdec8=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1205.namprd21.prod.outlook.com (2603:10b6:a03:10b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.3; Mon, 11 Oct
 2021 17:55:41 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4%3]) with mapi id 15.20.4628.005; Mon, 11 Oct 2021
 17:55:41 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        vkuznets <vkuznets@redhat.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Topic: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/SggAyEiKCAAJ8QAIAKHh2wgADF34CAAFhQAIAAAnmAgAUjYsA=
Date:   Mon, 11 Oct 2021 17:55:41 +0000
Message-ID: <BY5PR21MB1506118F97D27E3D402A5102CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com> <87fstb3h6h.fsf@vitty.brq.redhat.com>
 <YWApWbYeGqutoDMG@kroah.com>
In-Reply-To: <YWApWbYeGqutoDMG@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d6ac592-5f49-4a6e-baa9-ce19dfae1ac3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-11T17:47:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b41790f2-a611-4625-72b7-08d98ce0573e
x-ms-traffictypediagnostic: BYAPR21MB1205:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1205A7E1A94C8A25158082CCCEB59@BYAPR21MB1205.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bY0NKrlp4VZPCXL/g3JDuz4w6Q2TSxncjtjsSZEAKjegwayz23GewQPApUvzYwJ+ifUKr45BW75vTWB6P1QLIGDU4+zfJvNQ03v2N0jH78TIU4Gp2cRiOIuKTmjwCzbzMkxg6BISFVRvnxDyl3vqWtu4L0Nw232IDAnNSkYXNjGggW25gvkuYxWgN7AhoPgAIdvWK7u+ZnspgftzMwouhbF4vtNRY/h+cU6/BQQ/FTSAzZytmGZ/K8dk9zS+OB4ilAPCKJ5B8iSAk0K8a4Cchqv8SOlExQJGjnzjKlTAdewdTBBZJ+S/WIhdAHBWr1o38jESjdUY9lDqoXVO3KwZnEBzG663P0jYYPL/1eB5Q7wgytssx3Z73iJDy7FypHAAUjGndKC4oWX82Xt+EROkRj6dwO/Guf1XSdv771F2BPhYYbv99fG29VGZivqRMmC/ulb/pXYmplYWWRaON+fbxcIcJ4v64q7txx1g3p9wCzey2LQQYa2oa8fsk0gxQ4fTWG1cp17C4xWCKo+QqO7iWPvpwKGm6pssiicOwR2VGaH/j9Cf6vRW0yknYjmYILIMgU2wLo2eJCz1WhPXGEif4h+yF1t5Nh4Q3wW1QIzERz467TeEH/zTxI+XMQLRDaqryPBMtB2S7zrZISqZ4wF2rSdEZHT/wgt9ANg7NFH5HR0ysYJtU8OvBMPULONhCsEyJDGf5NI6XQiYjdXB0190ZCysRs1Je3c+j3PoWuxoRvzMSTmOmZazI+31Qf2QozrWU/B2rsgAsuCEPpggznq/EK86NOhNXQbwAMQ+Vg7+94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(76116006)(83380400001)(7416002)(82950400001)(66476007)(316002)(10290500003)(82960400001)(64756008)(8676002)(186003)(66946007)(66446008)(86362001)(8936002)(66556008)(4326008)(38070700005)(33656002)(38100700002)(26005)(6506007)(122000001)(5660300002)(110136005)(52536014)(54906003)(71200400001)(8990500004)(508600001)(55016002)(9686003)(7696005)(966005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bAwXvsQbGdDJ/JWUOrgtqM3vvU+WPeFe+oMfiQ7Bx+gtJUjEyOJjrs7tzE5x?=
 =?us-ascii?Q?Y4Sb83HS7jRs5eZXzeb6MjhbL44Y+/uV3uiW3uh3NgWdB4hwPs7GNBPTxOfR?=
 =?us-ascii?Q?jXbGsEczEYibgCigqbCy+Hd3HL/V9+oIoLvNypHZMkMpk4Dx/yqmUYMksk7s?=
 =?us-ascii?Q?jWFoDY4nholOIStvloaLQzF8IuNVpTmpu4BI2cbc9OC3/ni5Ku4q09B9EkMF?=
 =?us-ascii?Q?TWQYIeH9rv5pY1paYwsJuTg5a6Lc/9sS/I6A/UCRLFKiwXXstsFUAWEVWlle?=
 =?us-ascii?Q?XzRTzw661O1dJlQuZFIUKCsWoZN4KQOXTkbIPsCh38YS81D2UpLJw7pZYrQn?=
 =?us-ascii?Q?K+yx3lz9OFKZ5Ka6hVegbt4SMQljtLty7okrLTTw1BI0zmB9gHhrcc1Zbd3D?=
 =?us-ascii?Q?qBUqff2UueWf2uZ1SmJdplDJpLlNKMi6TypoekvSo9OkXuF20C5QtGu277m4?=
 =?us-ascii?Q?OtGfTwGTxodhZJ0PMT/ac1mniZg68eq/D5qJLoYp2lMdH2sHUD4vzcNqyG0P?=
 =?us-ascii?Q?e2zbEqZ1Mf/eRkaVtP+QI6WWgBNmwc6dbPgINKY8X4zG1+6Ac8Lhtevj3+LS?=
 =?us-ascii?Q?pIfTwfPK7+aPk5qDWbi6+FYTiQE5A+/2PEMJ0s0iEp+EGzo3aFQVP8rU+BkX?=
 =?us-ascii?Q?MYIOUIG38Bu/bMA8Pef5jQ0LBlm31RrNKgeNSsgTEUrrODgjnmL8Cs5TUkgo?=
 =?us-ascii?Q?qDUFsAr5pqd3g+IEFIXU4VmkfIf30C7/bK3Xkb7Y5WByjYjMEE8zwvgVI/Pu?=
 =?us-ascii?Q?aQrpg5ftBclU+9pxssUsKEayVBmXS1syy57IUURS9F/KILW93s8KtJ3+gwWn?=
 =?us-ascii?Q?8qKq49eOXCSuGTcDXFEPWgPrFTdMpKTVg9F8J7QU9QK4HE0Qs2Qi9OwfyQxz?=
 =?us-ascii?Q?fQssvPzriwvKTf0Lyoyhr82wPWC7Mfkra878DOOUU0CjbZm+a3DooVZIaOBz?=
 =?us-ascii?Q?RYreKSGCAY6gmzkztiySzlJn/offqmqIg9qnQdtymHkvxANU2rNRAKaguSxX?=
 =?us-ascii?Q?SlfOoGOZZMUUX0bPFn9xKj33mMNYOBR2zPUv9BZsT8uUIrvR5AYmD/LesF6p?=
 =?us-ascii?Q?YS8MZ0w2jQ+xj57deoZUtjQVmtnIgQxXOtft4Bl1SlvfCjOxpnpraSTAxWfY?=
 =?us-ascii?Q?iDSI/cBUmizhdQpOI5Ne8YDcP5uJIGQFisKX/QU6lAJ3/jAFPzmyGixATeic?=
 =?us-ascii?Q?FqvPrNaTch22292hVH++6d9ATEd9e9mqhDLexmWLDOwkDqain+OEesnJl+z9?=
 =?us-ascii?Q?wG0eVHspZGkn2766Budi6PzcQ7U1+BKFdwLgPKoTUS2e0jEm634xkj8IbqxV?=
 =?us-ascii?Q?27CE4xx9yryQhWTKNTgqGIBY+O711kUW18RjxzvyanjkC8JqZ2dB4GhIEyNZ?=
 =?us-ascii?Q?E059Hsf+NZy+NBMz5+T0siiwAVbhfyAhhr448ifFqSI8DZA9yRPmvrMidyej?=
 =?us-ascii?Q?4AvmpcfT+Vtte0QQpB6eBfUGDbpjAJvMZ5UILy+/IRuaudah/OnuX2wstoFv?=
 =?us-ascii?Q?0EqbcKsGIKkCIASvyAx6dj6QGY/jzdEi05TQW6Y4bnqlyENpCgzt/3IiVYd6?=
 =?us-ascii?Q?WzlTO6bVutI6B7uEw5/y95oB59hTCYSC80qvQqpT+QCrdQm1EiQA9ET86RGp?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41790f2-a611-4625-72b7-08d98ce0573e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 17:55:41.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TKKn812V7iu0gUebj2hcEVo2g9ATLsFtNhsxLy8eXIEmeZkzo/xQPrY6gw7Ayczy0Bh+la539CIDZvUXPK5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1205
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d access
> to Microsoft Azure Blob for Azure VM
>=20
> On Fri, Oct 08, 2021 at 01:11:02PM +0200, Vitaly Kuznetsov wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >
> > ...
> > >
> > > Not to mention the whole crazy idea of "let's implement our REST api
> > > that used to go over a network connection over an ioctl instead!"
> > > That's the main problem that you need to push back on here.
> > >
> > > What is forcing you to put all of this into the kernel in the first
> > > place?  What's wrong with the userspace network connection/protocol
> > > that you have today?
> > >
> > > Does this mean that we now have to implement all REST apis that
> > > people dream up as ioctl interfaces over a hyperv transport?  That
> > > would be insane.
> >
> > As far as I understand, the purpose of the driver is to replace a "slow=
"
> > network connection to API endpoint with a "fast" transport over Vmbus.
>=20
> Given that the network connection is already over vmbus, how is this "slo=
w"
> today?  I have yet to see any benchmark numbers anywhere :(

Hi Greg,

The problem statement and benchmark numbers are in this patch. Maybe it's g=
etting lost because of the long discussion. I'm pasting them again in the e=
mail:

Azure Blob storage [1] is Microsoft's object storage solution for the cloud=
. Users or client applications can access objects in Blob storage via HTTP,=
 from anywhere in the world. Objects in Blob storage are accessible via the=
 Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage c=
lient library. The Blob storage interface is not designed to be a POSIX com=
pliant interface.

Problem: When a client accesses Blob storage via HTTP, it must go through t=
he Blob storage boundary of Azure and get to the storage server through mul=
tiple servers. This is also true for an Azure VM.

Solution: For an Azure VM, the Blob storage access can be accelerated by ha=
ving Azure host execute the Blob storage requests to the backend storage se=
rver directly.

This driver implements a VSC (Virtual Service Client) for accelerating Blob=
 storage access for an Azure VM by communicating with a VSP (Virtual Servic=
e
Provider) on the Azure host. Instead of using HTTP to access the Blob stora=
ge, an Azure VM passes the Blob storage request to the VSP on the Azure hos=
t. The Azure host uses its native network to perform Blob storage requests =
to the backend server directly.

This driver doesn't implement Blob storage APIs. It acts as a fast channel =
to pass user-mode Blob storage requests to the Azure host. The user-mode pr=
ogram using this driver implements Blob storage APIs and packages the Blob =
storage request as structured data to VSC. The request data is modeled as t=
hree user provided buffers (request, response and data buffers), that are p=
atterned on the HTTP model used by existing Azure Blob clients. The VSC pas=
ses those buffers to VSP for Blob storage requests.

The driver optimizes Blob storage access for an Azure VM in two ways:

1. The Blob storage requests are performed by the Azure host to the Azure B=
lob backend storage server directly.

2. It allows the Azure host to use transport technologies (e.g. RDMA) avail=
able to the Azure host but not available to the VM, to reach to Azure Blob =
backend servers.
=20
Test results using this driver for an Azure VM:
100 Blob clients running on an Azure VM, each reading 100GB Block Blobs.
(10 TB total read data)
With REST API over HTTP: 94.4 mins
Using this driver: 72.5 mins
Performance (measured in throughput) gain: 30%.
=20
[1] https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc=
s.microsoft.com%2Fen-us%2Fazure%2Fstorage%2Fblobs%2Fstorage-blobs-introduct=
ion&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C9b9af86ab70f4c0e147208d95=
7deb1f7%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637637436286978046%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&amp;sdata=3Da8xHaFIsGEvI0D5u5cPFdzXT3WDtKXnmwtTSQj9byMY=
%3D&amp;reserved=3D0

>=20
> > So what if instead of implementing this new driver we just use Hyper-V
> > Vsock and move API endpoint to the host?
>=20
> What is running on the host in the hypervisor that is supposed to be hand=
ling
> these requests?  Isn't that really on some other guest?

The requests are handled by Hyper-V via a dedicated Blob service on behalf =
of the VM. The Blob service is running in the Hyper-V root partition for al=
l the VMs on this Hyper-V server. The request to the "Blob server" is sent =
by this service over native TCP or RDMA used by Azure backend.

Thanks,

Long

>=20
> confused,
>=20
> greg k-h
