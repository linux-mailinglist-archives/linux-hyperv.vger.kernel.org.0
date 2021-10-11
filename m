Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C55429603
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhJKRsx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 13:48:53 -0400
Received: from mail-oln040093003009.outbound.protection.outlook.com ([40.93.3.9]:19387
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232836AbhJKRsx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 13:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYjh5dJZMIu0/w7yM7OCVc24Qdb9kLhrKonmogF4KvyzIYpDwwmFUV/xz9LSjJteKeZrNwmXV3ftnGO09yjSMPlVeywGY0QPzFUsjWkZW6QDwnXne/ckVsIPq3lmFe9nEdmCLhra3PIopGogmbQHF7soI3NEeQS3hxGlbFoOzOCFRPZtDyjYk6A3/Zv6vbSKCRBHEC3YSkquUv361Qn1hBeiN6UK4VrE8d+w0TIv6e/16cu3GBRDfDuex1gUNQEHwV3J21yYhz4QJlGy4vTBCkV/wn2FvjF9TBrlsTnLbKCEKP62Ly7shypk1DFb5OffsDDjtZIQT1mVRjczIWlQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rOzT1tTVVNg8SdwZIjqBgHrWSBa9KjtkrL0WAV651M=;
 b=c0rvQWOInemN43OSlnNsU7/wnLD7WCgLAX9ojEVjscT/rlQAGFRBQ2GaPd6XaQGEzTBjA5Lgejay+0AMF7o5nLyPgZ4BoVObvnq4fltApsPIt7M3q0LZls1/Y5sNeLDvivcHyYDTMXzSnwP6YZWL2F4YqxacL5MeZqp51FCFbI9n+lfb66j391QDJcq070k4Q+/HrgQpYx3F+WJeLfZGZIfJoAcb/SMm0jLYieEFv40d0CO8ITXlaZPu6gvLBHtXu1IM+pMyxUkQQWn0B9O3R2gXObTc9BriPtjdB7m6DO2zkugubnMEexaDFUKnZ6U3SnyhLk+mjPF/qqFWIb5FxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rOzT1tTVVNg8SdwZIjqBgHrWSBa9KjtkrL0WAV651M=;
 b=Ne3gMKsgaCgGFDZTKOrZVOj/JN8VALlNM8jbr4EquU3NNXjVLCMv3CmVcf5wn/5yG0QNv2sJwAhwukaGnJSoVRRHoFODOQdn+AxrHK826w0/uBUxPdxfijcwc/odOtcLLbSXJ4nhNYQrA+OZoI5ydj7LfnlNmrduWEoSz/356DY=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1144.namprd21.prod.outlook.com (2603:10b6:a03:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.4; Mon, 11 Oct
 2021 17:46:48 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4%3]) with mapi id 15.20.4628.005; Mon, 11 Oct 2021
 17:46:48 +0000
From:   Long Li <longli@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/SggAyEiKCAAJ8QAIAKHh2wgADF34CAAFhQAIAFJJ+w
Date:   Mon, 11 Oct 2021 17:46:48 +0000
Message-ID: <BY5PR21MB150612332F31358E4031A080CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com> <87fstb3h6h.fsf@vitty.brq.redhat.com>
In-Reply-To: <87fstb3h6h.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a7fea1fb-92f3-4de5-8432-f4b2b33f3d72;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-11T17:43:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41d05e03-a123-45de-fdb0-08d98cdf19cd
x-ms-traffictypediagnostic: BYAPR21MB1144:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB11442A6C935AAC86C16CC6FACEB59@BYAPR21MB1144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQHFH1+74lxOTE6VdoJNHurOZaEybU7guN+wkcP809+m6WpcjmCZ8Pz4v5KDdkL4Z0fF7vsJX8Pk3rp430MmjtR/V79eCnENqJi7bE2IW6NC1fmiE+OCwLfOwtO91QdEWI9QZcN6aeIjvWKOpdZJSs57JcCm8hDmU8PYA9vE7nyXW4eSnZrG9gwHxUn4ZurhC312SW+uyRQuBUuh/fHIpvvo3crJHdFOLPVPsD1mszhGtDHpeHoWepfI6ahsZFDYnynrt2ZS1mfNo9Qq26oBNTXZTqOe2HnGFKrjTqa/mkSGM/2zgzoCZNKpLBqxybl+2P/f7RzYX97EIP+WpiBkx0fGlIB+VIs+oddQx5xHyuxtA9tP7fZFPT/WDHXLl9Wb+k2BZUqS2rIGyawYHRHxfdsiX/rOxNS9TNgMWoy1/8BH6r6DyK3wU7JAQJtz+X17fXHcEoCFW77Pi4zlax8PXK5h1DFf81MrcoztHgbpl5z4c8WqhNAhumfvLJFBtPlTQnmdLogim2JYFovtyyr0BZaKLk1kywx90942RCZqkS5eXhmD5r+7wUF/vVEBHtXqdXtSSvNQAewfsC1sDoqSCOJzTQi+UjdeiuHDLgqlD0GvKkds+E70V0t+Kr+IBV08RkyBZjAZZXLTPrIqjm01tTVRqDRR0izppwucZ2gzkB4fqUl/tBz+jJO3k6zFCN43GqgkVO+81ySwx5LVvDM6Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(54906003)(110136005)(9686003)(71200400001)(38070700005)(316002)(10290500003)(33656002)(7416002)(38100700002)(55016002)(8990500004)(2906002)(5660300002)(52536014)(64756008)(66946007)(86362001)(6506007)(186003)(7696005)(76116006)(8936002)(8676002)(508600001)(66476007)(26005)(66556008)(122000001)(82950400001)(4326008)(83380400001)(82960400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CQ0nlwV9d/E2QIjqPQ8WU0nXbXQ3cddzsQevlb3kMMtOOG0dMsTCn4uE0nxL?=
 =?us-ascii?Q?9N7IqNFUF/pw63fWyUbwEtg691kfsEMOrSszF777PhWpoNOKUMAL76stlIzh?=
 =?us-ascii?Q?EvzLUnYHYAx2DAbzjRevLUgoxWqAWWkqvPZDcZ7ZtRaZFKSX58kPKrQdsCBO?=
 =?us-ascii?Q?y4NTV2PGufM4K8C6C4ytMckI/gn3W1Ck2lIQjkLVpiHTp3yspK2RrsMxbMz9?=
 =?us-ascii?Q?s18hGIfWc2Ovwwk28eiz1Jz3CGkB0HE6EAP0WBRFSD44BhaLnySD0ivjirfL?=
 =?us-ascii?Q?+M7D8TxkbHmAin9fiCnX/J64BTLyQ5df/PpVj2e+/qOpjq65DKBwGHlGGfIs?=
 =?us-ascii?Q?bXVYhVMLMU3NSuGa3b4oYmf3uS6q6UljcmSLMmis8Vrm7SMlw1SJeVp61tVU?=
 =?us-ascii?Q?1AKfuHE39FPCXBbE2tHK0TsSSgd+SO0Fy1/1LGOd3W+5/MIMJGrX37T/UMQ2?=
 =?us-ascii?Q?LmI1AfAjkhfVBf6aChkc35otmwsPk6As0BBRz+yFBCGDDIrTPRETJ4FVjZtK?=
 =?us-ascii?Q?CIC/TwdjgGQQyjcH5yi4ay3hIGiQMQd/g4KyYcI7O9JfKnjpf8kzsNytPpoY?=
 =?us-ascii?Q?BhZrgwhzjfhFZavNFgnwSiYXhaVZZf/ukbw8KHM5DqpZDsEFOqRxw+mxiHDV?=
 =?us-ascii?Q?edhMHVpqn5MbQjY6tYjWzcIPaVWcHbjeTJyILKpdhuJezIRhYMQdilEGQVin?=
 =?us-ascii?Q?zWf0qfL6TKN4Yrl4suEEWRqOrnYmk1k/F7i16aOZQaSup3mRAUCDFQeL5D1Y?=
 =?us-ascii?Q?PJmE+rtHDpX8mccNad4yJUxeNkJ/9Ccsb56AHZ8gX+qCAMSBMvAtlfaqvrV8?=
 =?us-ascii?Q?u/ysshmn7SmY0WqIlaMIiAkgM0NDJBUv0oMYTAqT08dEtNip8GSy3t0TfKwT?=
 =?us-ascii?Q?uJPwbEDhxc0G7PmE522ss9xr7kORv7gtXzAhUXaG18WRkucwJgmFspnjoZ7B?=
 =?us-ascii?Q?q8hXMA4Mdm7HGq6gADDim1Gtrt+UmHcWxFD/rVIDyMrh653UeiXSxpJ+mdBg?=
 =?us-ascii?Q?3OPnl5NWSSsKsDpBv7fCrGaLqCtWduqMtQaf1o6D48DTKdozCjiRQZtr9Es8?=
 =?us-ascii?Q?np575Nvcn6KIP/ZcmQZDSc16VaoONEJ3d6z1mlqdhwSLmjS23At0OSM5Tp5h?=
 =?us-ascii?Q?12ikiNe1hCvC1zaDxAYwCIgPe7JFZdRgpTT65jdBGuZcwfN1COv3BCGLSJtB?=
 =?us-ascii?Q?pb1UGIBVw+8wQdvbxCqETsGMHyfwQjzJjfFaEL2sAhK/dQIyLJhjGivdLxoA?=
 =?us-ascii?Q?kyeS+l8CXkyC3k/IS5M6T9Xy4jdYbFOvJ0KwRr+PE4nw0UeX3zibdMdf4uvz?=
 =?us-ascii?Q?tDEGTADqf3d68UxHQLzHqi7pIVtZ5KhIFcm0c2NUIiHW1gIVFNcSiTJuF/tL?=
 =?us-ascii?Q?bhnZuNe1LCSKwIOwzb5W8rCeVtHI3q60G5BmVt7V2bJSxh3Qjb8QkOOtMjmp?=
 =?us-ascii?Q?uzjk8lhsUpRAs7GbX3RLhW5gyA51Bf8DrmvGO93tAArIqXANO9CYPOlAPL+t?=
 =?us-ascii?Q?zJimmcz34DevO/I8friDcN1vVH7woUJAU/PfJQ7jQTQvNq7Cn1HEsoOireOK?=
 =?us-ascii?Q?Heu8tRj7HLOIC301UVZDop63cgQv/VXNj9EmZ5P4jtpSrheDAYl6JWzsw+nr?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d05e03-a123-45de-fdb0-08d98cdf19cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 17:46:48.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGcy2BGTahoY+6ZxLOmQVD2RDGIcsMYAYtjt17CMn2h2K8Mt/uoBurnQyRSBtLlf3KlG8vFBj/vH5QHIFidqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1144
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d access
> to Microsoft Azure Blob for Azure VM
>=20
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>=20
> ...
> >
> > Not to mention the whole crazy idea of "let's implement our REST api
> > that used to go over a network connection over an ioctl instead!"
> > That's the main problem that you need to push back on here.
> >
> > What is forcing you to put all of this into the kernel in the first
> > place?  What's wrong with the userspace network connection/protocol
> > that you have today?
> >
> > Does this mean that we now have to implement all REST apis that people
> > dream up as ioctl interfaces over a hyperv transport?  That would be
> > insane.
>=20
> As far as I understand, the purpose of the driver is to replace a "slow"
> network connection to API endpoint with a "fast" transport over Vmbus. So
> what if instead of implementing this new driver we just use Hyper-V Vsock=
 and
> move API endpoint to the host?

Hi Vitaly,

We looked at Hyper-V Vsock when designing this driver. The problem is that =
the Hyper-V device model of Vsock can't support the data throughput and sca=
le needed for Blobs. Vsock is mostly used for management tasks.

The usage of Blob in Azure justifies an dedicated VMBUS channel (and sub-ch=
annels) for a new VSP/VSC driver.

Thanks,

Long

>=20
> --
> Vitaly

