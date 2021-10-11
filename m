Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1864297A0
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhJKTlA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 15:41:00 -0400
Received: from mail-oln040093003005.outbound.protection.outlook.com ([40.93.3.5]:34958
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232027AbhJKTk7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 15:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmCe/4cVJdgbAEQjlp4z/j/MmtotqEJLJMq9CpTN098t/t+uLLlXKK9b77PXNxRUqEhu2b06FQUPO5Xsed77SI1yKZRQJQq3bED7iOVfoYt3H5Q/18Az6jWsFllIY/q1A14bwcxpiWV6LFUrpgLaZCqhXKGKeBEJ50+NzzfhHt77jj5kYIuzqXpMRnTWMeFyGw+FR0XeExNYKchm6yNIExdXTrQjhOAnM5NhRzS3Iwb6ADqt4xHf7yqTXj5UN+L/+qB4Beay4bVAWJF+1vp1tga7wjlMZwVSGQ+it4o04Oon9ESzLNTe/vDUcdRIc33mY0/JwhM5yj1EOZodkgIQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxE/CoCrdrIvC7VS7sfs3P0AqmkpcCHvUcknfiHXx94=;
 b=UUh9B6DPVwW7zXeyUWPS9H0U9ezPhWHJexBhKDJaeTkVLO/orz/A/0PFAP1rAUHuMy/9SDZKy+t3AF+fbKkvZ5FUGK7wrxqDFQHWZPiQer5aRHKYQeT/wMfE2P4A/bDcN1vJRZORacnpwp+K1qBGFRHkrpRM+Mw7desZSv9ls0mXRd6IeNYFHiqIzHUa+8BHyYdUeMlpltpTcgLAr3v/jc1Z8h5QQRd3gVshBnbNKZF3IsYJDdaPacg6Sv7L+OHSPKdbc9XOjhLd3cyqeSFw2hpY4Ns+omjIlC84eJk8UiviAyJ8/YzbYOe7/GO1p/Aj0U+Q53TSDh+RYqy26NNAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxE/CoCrdrIvC7VS7sfs3P0AqmkpcCHvUcknfiHXx94=;
 b=XLHL57tZZsoldj7iLgvPNkjGHm5b6gBBzDHiYFZZHBqsTdERY9+ZtUK+jDWvLO+vuLE/D1IZn2pcfAfnoSEbQjBxLzGUDX/cTxbtkI+m9vjy049wMMF40ydw4QjDLTT3+/EqeTpemjsZ8JvesKozXFcvopztvDpBC5hiaSGoa0Y=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1366.namprd21.prod.outlook.com (2603:10b6:a03:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.3; Mon, 11 Oct
 2021 19:38:55 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4%3]) with mapi id 15.20.4628.005; Mon, 11 Oct 2021
 19:38:55 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     vkuznets <vkuznets@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
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
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/SggAyEiKCAAJ8QAIAKHh2wgADF34CAAFhQAIAFJJ+wgAAEQQCAABalMA==
Date:   Mon, 11 Oct 2021 19:38:54 +0000
Message-ID: <BY5PR21MB1506196929D2BD0300B4388ACEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com> <87fstb3h6h.fsf@vitty.brq.redhat.com>
 <BY5PR21MB150612332F31358E4031A080CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YWR7TuGNaMJLXdVr@kroah.com>
In-Reply-To: <YWR7TuGNaMJLXdVr@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dbd7c8ed-d2f6-4cce-ab12-9625109fb556;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-11T19:19:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b3bad56-c37f-42b2-b5a5-08d98ceec2f2
x-ms-traffictypediagnostic: BYAPR21MB1366:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB13664D45CF8712339752787DCEB59@BYAPR21MB1366.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93OeGFbkrOoissKU0h9u/zyrX29kowB7+cplf4LLemJq5JtSjH5GHadT/KroynQXRRMwYDO0rYG4byh7YL++y5kpcgnDjYYWeuvLyVpJv+EDp38kJ9bT9Aq8yBzuGo1mWElqyJGIZ6p0hrSpT/EuavtJzfXrEXsTtSg/yoVNbvy1/UeEmLtgwVYvzaj7UTiobqSPKW6UCEuoXdSZpV74i6BwYuuwYFsazDr5ahB/rv/Iwjiz3kSByjySJCgA9a5Wb9MSpVkCcsMgFVrMAYYS7jPr2ltUdkUdQEXFMjDmLmTm2VucYiv8O2xyQ9MRBzHuPsXLtBVphhLBBYk9argCcG7OMOfOO+2iwUKfmEtyxBK73nNg9YKKfLnT+f9D51ZcCAYTt+CsvV0YP97GlbgcIMWW36uCjNFreU7FMowDr+TJ3NCLC6XS+DTXYPHVm4fWyiLR8SAsgdvXutUxjOiUpb3l+9x+pTER2q8IxAEcJ0hX8cfe6jNgs14XykJMS1lNBufJ626SEmB7t/F5J7/PxLWmy05P9CJO7TvjAmkMINUsaHbg4a4q0Un+VnDOlUtQZ63jApT7ghMio5iP4OJjTRjL+Kbbaxx7kFUw1V9e1z4CrlkGQdN0TqIfCgMqwIj1Bqpx9k77o3yage96BMadP3EJdx1NZXLpqbDqE7akSESI8SNFYdJyWF3ib750o9qcW/H4Qw34tjG8nM8pqqrfuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(66446008)(66556008)(66946007)(10290500003)(6916009)(64756008)(8990500004)(38100700002)(8676002)(122000001)(7696005)(508600001)(38070700005)(26005)(52536014)(76116006)(66476007)(9686003)(316002)(55016002)(7416002)(2906002)(54906003)(82950400001)(5660300002)(33656002)(4326008)(86362001)(71200400001)(83380400001)(82960400001)(8936002)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmCBIGkoMPIzV5gU2XoLdKp338lOZbDIHDAsIQprOHBk4LzqYMENtQjRLUgQ?=
 =?us-ascii?Q?alJBwXWECk0Gao+OsxTSPT4tq9BKQhY1iyfDB0dDHuWc/nvyOQkvlyWlrCWq?=
 =?us-ascii?Q?mWmF1xBl4RTNjfnlbgzBDSXdMTFTkz/0b+9nwkigE8Kh/oLG+en2BJJr8v0+?=
 =?us-ascii?Q?drxwVprHd+jBSzrOwfbCCFOrVAIctGiwqdvwPSI3bDwzZwalUeOkNgBvCWVq?=
 =?us-ascii?Q?NrLoA/GydWiaV8qUZJT6cWVm0bAQB240B6uTJDkaw7aKJAI7dwNdZqkvX3Ne?=
 =?us-ascii?Q?wvNpB9HFsB6eiTdrhIDsvFe53YU7VJTvHmbsyRwlm4vha3vxVPREcshsPLO1?=
 =?us-ascii?Q?xqm6Njg8MwO5I1XysBvIirXFrK1XOCW8PffhQU9t/vstMtARJkwWKqHx6c4O?=
 =?us-ascii?Q?Cfm3mbZshB6n8L5E8UOyloZIz2tF5Cs9Bi1S6azP0PymLlHp5D+FgK3IUdMJ?=
 =?us-ascii?Q?UVMxmgX2xV1aW0vPBh98s6IAlb/o8AUKYT9LWf07kX9UhAHN+la3VkfDqABu?=
 =?us-ascii?Q?sk8LoXbfqaRSbBm+PlcB8cd4sz7GtUsge2b/x7u8tcW9WdzK18D3cV33nIrH?=
 =?us-ascii?Q?vldFpVZA2mceFYTKQaUBej94b1ov7CQ5bG9h9bqCgz4OvXk0eW4rK7jJ3N49?=
 =?us-ascii?Q?2WvONlSvJgohyo9ubl8oKUtlbcJc/K0W8E1dPs32cES1cW/nRCNpLkys1uHJ?=
 =?us-ascii?Q?djWHFzMDR6+C6xqGKalkGyrqTf+3y639M0gjxjpnFSgGgIQGSlTWk0c4ctKF?=
 =?us-ascii?Q?gOy1NpIxsMAsXVp21X1lPPv0KN+OxVQEcq0uzFZ3DbNWvlmEQWan0I6NLZEc?=
 =?us-ascii?Q?Mpj3Zh+2RkTivSxnGK7i5f4m201DlAIn6u6B2CDtmEYhTTEErD3eq7Si508Z?=
 =?us-ascii?Q?xde3sclbVO3x8pN+/o02vLV+1izKT+0qv5y7cFLlbCBCQepVMeMgQfZLMSDx?=
 =?us-ascii?Q?T4oCHuy/vf42IETV9KeE1rdJ4rwhgzqM+fZ+LkrCLeTGW4RpvW5ybKqb6xr3?=
 =?us-ascii?Q?/ezuCfjxyjpKun7Kqt6jQ71rJLiVpqOrON3YaEtKbc4EWgRk6UiS1VDg59ha?=
 =?us-ascii?Q?nRcQz1XdX5m7SBB4vhptmO8fUFsDpefJfwmUmoWbs7IdBV7wttsTp66rs7F6?=
 =?us-ascii?Q?N9FdLpuctiCeRaw+LcZUJpXAAwlLSDX/c2JsDzTmJSWh0F5y08n2UbLROsbK?=
 =?us-ascii?Q?Yp4UJ0F37ah4SQQurx9Uel2XHtaJyEXqLKmXOQgk0l4zPXS72q2qd0Pm8exn?=
 =?us-ascii?Q?2FM5hDiLJpixwKPTZFyaMPUzx7LacyjV6/ZERc2ElU1aI+J/F7Am06R+LWe2?=
 =?us-ascii?Q?fbWLMBYfKRM9FfPsbtON4CwWn3WEGwoDEwHYUQZo7n4aaoIx41/QoJIrwOH6?=
 =?us-ascii?Q?O1XAREeDbxBSz/cH8hdvpPXU37oDxR+V5xjTrmESTvdp7NqAIEp/ZXhTiyHo?=
 =?us-ascii?Q?aczYAwwLYr1FNtXszxtPYLN2Cj669o+GRbt3HWkzBCXbE+XgA4WKhhKbQzR+?=
 =?us-ascii?Q?mX6LCNGHjD0vOHtgnN+Te+QIi6FfsvLaoyQqm5Fa2FXtqz75PMF35MD54l7P?=
 =?us-ascii?Q?R3az137OePLe7kYYIVE0afOt2zFvNGZNdjFw8dzBArDKnVcyJKx8SMWR7UR5?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3bad56-c37f-42b2-b5a5-08d98ceec2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 19:38:54.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTh5aS8I4U6IFMgUmITO6SQsg7G3eiSmqHEb6cXIPU5LWwuPuCS8cDNZ1XdJNqK3dcdFiQSrOWNYR7F4ElxGIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1366
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d access
> to Microsoft Azure Blob for Azure VM
>=20
> On Mon, Oct 11, 2021 at 05:46:48PM +0000, Long Li wrote:
> > > Subject: Re: [Patch v5 0/3] Introduce a driver to support host
> > > accelerated access to Microsoft Azure Blob for Azure VM
> > >
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > >
> > > ...
> > > >
> > > > Not to mention the whole crazy idea of "let's implement our REST
> > > > api that used to go over a network connection over an ioctl instead=
!"
> > > > That's the main problem that you need to push back on here.
> > > >
> > > > What is forcing you to put all of this into the kernel in the
> > > > first place?  What's wrong with the userspace network
> > > > connection/protocol that you have today?
> > > >
> > > > Does this mean that we now have to implement all REST apis that
> > > > people dream up as ioctl interfaces over a hyperv transport?  That
> > > > would be insane.
> > >
> > > As far as I understand, the purpose of the driver is to replace a "sl=
ow"
> > > network connection to API endpoint with a "fast" transport over
> > > Vmbus. So what if instead of implementing this new driver we just
> > > use Hyper-V Vsock and move API endpoint to the host?
> >
> > Hi Vitaly,
> >
> > We looked at Hyper-V Vsock when designing this driver. The problem is t=
hat
> the Hyper-V device model of Vsock can't support the data throughput and s=
cale
> needed for Blobs. Vsock is mostly used for management tasks.
> >
> > The usage of Blob in Azure justifies an dedicated VMBUS channel (and su=
b-
> channels) for a new VSP/VSC driver.
>=20
> Why not just fix the vsock code to handle data better?  That way all user=
s of it
> would benefit.

Hi Greg,

The Vsock is connection based.  On both Guest and Host, the model is around=
 a connection over a socket. Internally, the Hyper-V creates a device for e=
ach connection. But it doesn't scale to large number of CPUs over a socket =
connection. Hyper-V vsock is designed to perform configuration management f=
or a VM running on Hyper-V.

The Azure Blob service is not connection based. It doesn't fit into the dev=
ice model presented by Vsock from Hyper-V.

Thanks,

Long

>=20
> thanks,
>=20
> greg k-h
