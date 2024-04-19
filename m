Return-Path: <linux-hyperv+bounces-2010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A823A8AB4E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE261F231E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D77513A41E;
	Fri, 19 Apr 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="esA0Grft"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021006.outbound.protection.outlook.com [40.93.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19313B297
	for <linux-hyperv@vger.kernel.org>; Fri, 19 Apr 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550546; cv=fail; b=Okl9kKfFlaWWV9HHihT36sQQ4VRHVUHgcTd8xuRKSvS/z4SsGV+VeezbrVqQJ2UpSWB63HcvbLVkeLc/Pm67C3gitQ49wn75YxuHtHuMz4Ma8s8dKGWe5X/LLci/mSJBd+flDyC0S2kiRfWuHnzIgFQy5hXItMuAR146ZNlzAE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550546; c=relaxed/simple;
	bh=KQZ+p38X0C//X6hUwAwWBV8DBi9MrD5iv2QRXNYYz4A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l/U9NWNjWxF96MllCw4aeArCXIhLyzHumNzIwESC8etSItzYsSkvpbhIUW88uniAQM0M/3je0KbRNFgQoeHGnO24IJ0TI1yptpgOJ4XCmZIYeS0inMVTa7vU/0HTqXJnSReMVy7paUiqYXltPykfL+CYAL2r36lmTiGEyBBxN+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=esA0Grft; arc=fail smtp.client-ip=40.93.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ12HMhO3OMU5gLs3aEAabE2sJ/UY9IY9V71ZzUjvSInUPwU5lxTaGAsRYQ4d6wm2yuAbUNJGIwcjYkbRXsdQLs688G5pozZa3Gf2FMEmW+HOJPuJAWgAdWa80Hfj3cV8ys1wAXSUa/5GPH8vX1u7iIB9qvtkL9cYxNPCZUx/R/lNTxw6c5aWEklZpXvPLxWVDiBNcnjWFB0GxUhpJzwz7/MeDV05y0RenVRupmxzcggB85ZIgLxlhHiUhTCCztTNXChjtZjc9kNX1UppKzxdsJ7kYnAxxSbdivACdkARZ8z+wHX7+yaY5NfoBuOm0/c5XfwUHXhHR0sMwvY9IJOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLkmltg2bqrrDyd+aHDXLxsR41XTUnhptxj+BmV8LwM=;
 b=jaPRKw1WrIPgKsV6gZPt+wqi+Gflgt0vpFOwNB6sR1DtqNe33dOmo98JG+nLMGSPH+DoDZN3LDGNPqAq0//syihkjgHdwpatmKgZzmq+RgfMeZ0BIbOI+/Th6uhNIT2ygwcQ97krn5cFyBfQbbj5vw0sE8m/nxz8gFGMlFnIWt/9GGh94yMazj54LCdntNrTCn97UszpzdgtTIrn6ihwH7SU3aOp84U4ASK5X6NjO2pQmfvqYfnP71Ayz4MJ83THbjhb4KYVpYYNFgTESbGEakjVba9T2a2vkfSnKcZR8+gSdjNz7RLoxOg73nmruAwBjlpg6/d6auOILGrfFpUuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLkmltg2bqrrDyd+aHDXLxsR41XTUnhptxj+BmV8LwM=;
 b=esA0GrfttCi8yJAxul+wAh6OSlkdu6ablwgPemoo3zHvYndx/jl6zejP7dzAi6a8G+5xXd2N6ZKJoZ/xBYLSPZE8U+EH1KjtAVKQOz6+Sso0eThSXLwjLZ7NMtg2IFd01UzxqtQbQygGsXqNBe4aFEF8XxeWB5S2MgnU/rIWd/s=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 DM4PR21MB3296.namprd21.prod.outlook.com (2603:10b6:8:68::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.16; Fri, 19 Apr 2024 18:15:40 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e%4]) with mapi id 15.20.7519.015; Fri, 19 Apr 2024
 18:15:40 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Francois <rigault.francois@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: Nic flaps for 1 minute when reconnecting
Thread-Topic: Nic flaps for 1 minute when reconnecting
Thread-Index: AQHajo9NO41zm3JRAE+iNKJVCmlKjrFv6y7A
Date: Fri, 19 Apr 2024 18:15:40 +0000
Message-ID:
 <DM6PR21MB148125DCBFA3AE71E35B8019CA0D2@DM6PR21MB1481.namprd21.prod.outlook.com>
References:
 <CAMc2VtSNEb1yogTs1fy15xW94_UwqOUVoxaLS2eJ6mcpiaXOXA@mail.gmail.com>
In-Reply-To:
 <CAMc2VtSNEb1yogTs1fy15xW94_UwqOUVoxaLS2eJ6mcpiaXOXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f901be1-b0fd-4b9c-8efa-2ccd985e6bfd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-19T18:05:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|DM4PR21MB3296:EE_
x-ms-office365-filtering-correlation-id: 9f37179a-269f-449d-4ada-08dc609cb84e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?kKKUwYUErVJA2wuErZw1fVEY6dfpWPMqNHxl9JTWrPtPFuQ5Q/bEDBC4y1?=
 =?iso-8859-1?Q?jlvYmOG8xbixvBjPgXRdbKV3JLpLwG8fiMOg/+lWrGYKXH+Il7wN5riGHQ?=
 =?iso-8859-1?Q?uVJzlFwtV6XCCR98SqQihHQyFQ9UZxOh0z9D3dsvEvLzr6l8tNnx81YOll?=
 =?iso-8859-1?Q?y3fi6hPc76ObCvCKuN08VygXxO9SMCYR2JyyfY1PAr3QN04uG3HiGxMm++?=
 =?iso-8859-1?Q?nO9VnP8lAQvoLGnW3z9QaxiAmHY/pJ2Vyt/41lAroX83jCUfwVwfZ6SohI?=
 =?iso-8859-1?Q?+rsScp66gJr+IWd8WSlfBSEXUfmdvBSZjU4pu4zMyKNzNtiU93vqtq/5bA?=
 =?iso-8859-1?Q?7EFhWYkTODvWNgZcfPQ/v6HZlFkzxoeSbIxdnOGQOP5E5JQBmLT2V+CxT3?=
 =?iso-8859-1?Q?vGbpIU7kJtSUQLUL12pNc4uVMMilrHm/zAAJVq0QdOl2o/KurtnsdGQVlk?=
 =?iso-8859-1?Q?hdvHf4EsEgPOCCrRb1yZ1JMdjL/Wem/HjFwKq1QnYpp2lit036JmBrEqJN?=
 =?iso-8859-1?Q?/XGTHWNlWhxK7i3RMq0b6bjiqNE0b+FVQYKhRmT2hvFaIzc6A4PptekO0a?=
 =?iso-8859-1?Q?BTWAQW3Oi6HZ+DRwLPBuA/X4pm3s7kDR9PleQbqkz3kmLB01LNvC4YSoiU?=
 =?iso-8859-1?Q?I5SzFZUVjvaIYVouGmM7lsynPUkC5HyrY5Piphk2EfF4PpzaOkJwuw+ndb?=
 =?iso-8859-1?Q?6DrCt3baLKtK38mSnU8OrMz5hXuzm1/hIH0YCCAI/RPyjg2AiYBM1zJbMP?=
 =?iso-8859-1?Q?izsLrstfl+0zcU95/bbcFJtnziDUpkO8o9pe7pMW8hrp/8M7t7Jir7Cn/i?=
 =?iso-8859-1?Q?RkDS8z6/rpfwzvJY9g9A5MwoR84TFlWTp7DRyAr5vNM+7AaZf3J38wZxu4?=
 =?iso-8859-1?Q?8ihnZyHTDZb3+vWefE9X/RXuNIkMeDzITLYsV+BWueINAyj0i0nJNxd4vI?=
 =?iso-8859-1?Q?jk5I6wTJqY8O9Q70zUA6JogihRu1tHybEGZY+dumcl7IiVdZxApeuBV0wI?=
 =?iso-8859-1?Q?/da2jUdI7/bf+2laiDUfbGp1qsAE5nze0wH/7ICay4/FrikCkEUKZq4rjo?=
 =?iso-8859-1?Q?sRuOyK0WIkfk9hd+FQqn6SM6g9XZ+4DSirnV28BtmTso6RwUruIwXSSeOT?=
 =?iso-8859-1?Q?bcDi3cG2vT/oJeA5hABy3tXufTZNY+1rcG16sAeh4smItz2bfiaJaSCDsd?=
 =?iso-8859-1?Q?uV+j+Vp4ugVQ19DtTkXv0qThovwv995MDvpxV02n+uaXyC2h5JYF+aNPIB?=
 =?iso-8859-1?Q?gRSKyc768R3/obE5BqvQIB0oGuXLTjEUNb6R++ARrcIfwqxh7sVHj6cm5U?=
 =?iso-8859-1?Q?Uc0B9WZD9ZILvXHLOuIzO/6gnnugxEnYK2ZcsV2kqdqnnYNFS0RbWvnyuu?=
 =?iso-8859-1?Q?6O1QCxcno6Mtx8cgDQos2NdRwVtx7TLA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rlDZ9FO4Bib2iF2lvCZeuQ78EdWoFYv4wcrjLqcrgTiF6MT7w4DZUEOzJl?=
 =?iso-8859-1?Q?0H8Ha7w3oKWzH0rHxu6X5uApm1Ap4RFLlVkNzdl9UIl6JJiTRuboUsIv1I?=
 =?iso-8859-1?Q?E9UUcgdSx4vx/52+a3AEpfNDV4Xse+BPeEFxGFZCAEkNyoKMeONfPwDaDu?=
 =?iso-8859-1?Q?vAwD6DO2INjVGpQgp4OjiL0ebgbOi8opNytNVTv3D2hTJ0dciLG1SqZDcb?=
 =?iso-8859-1?Q?UvzDuk+Z6wM7NrGRgMNKo5IN6110O3Az5D9sMpbcznBqCPoUjPmlauRK/m?=
 =?iso-8859-1?Q?eTVnvO18wOs1NzgTvdWwfaej+waFgwRN15Lp5RzL3fqmgNvS3qHI4waYiS?=
 =?iso-8859-1?Q?LXGJL7mXn6VYbBFGXDxz3jMqyuCQLgjvrzm1PEH8V0Hdf9z8NbvbbQgX7B?=
 =?iso-8859-1?Q?GC5/nyIOcETUFXp8CF8cK4JcAGovGZWmHhSB4OQLLqLsdZKSa1f7Z72NIu?=
 =?iso-8859-1?Q?EotyU6fPJKn+LkbxwCFNNHSiuaBurqtNkgIQuC42Onsabfth+G6nYgl03D?=
 =?iso-8859-1?Q?1/yoBG4czbjwHEItkcA8e4KNvr9gcQSl3KlHvRw4LNDnMPduIAFKg0UV0Z?=
 =?iso-8859-1?Q?0XNgafbmWo2Pjp75lj7CYaavLKq9c5Qdh3nvleEjhU05y71k5jMmvr1wxY?=
 =?iso-8859-1?Q?UpGA8lCPo34Lu/vsq77OENLYEOL7GcJUVpL19F0FiGjEFpHWbT0/uYV+Ha?=
 =?iso-8859-1?Q?SbsTuK1VUd2CGGsv2nCJAkCjlrSdq9/oEesG5yqk2TuMcpum5oHVY8kLWd?=
 =?iso-8859-1?Q?DAh5vCxiNtU1vZ6NdR9OTiF6AQb6XD8FcgUeGzvGFUiJVDEPHj1gAZdDJF?=
 =?iso-8859-1?Q?WwBrypQxlnmrbX2kteMyOBGKserlrtykNRKm3cNpClWiNuKgmfCNqBHDVP?=
 =?iso-8859-1?Q?+htoIFExvhVGh1GQlZLKdjxfB0uPbzeDXdF9zJsPszkP/kgIBi4jsDXs+5?=
 =?iso-8859-1?Q?ZwjM8QBt/whEuH2ZQeI85OGQfdrAxIP7VFMkFrFy8rTg9EQbEDcMRD9fjq?=
 =?iso-8859-1?Q?sV/R/EW+tDTqhpzWKsiezINWYjdrb8+XjW42c/jO+Shmb6Tg2GRdxUNQow?=
 =?iso-8859-1?Q?2qtN8ISwd2l9e3I2BwkkDxDlB91v4JVbVckNwVDuZ7r3cidFOfp8UnStgb?=
 =?iso-8859-1?Q?5fcRFmAD84okvsUTw1/W+uFUeKvUKEg8kYan+IRLPQP1EgmlB3lBgdhvsR?=
 =?iso-8859-1?Q?bk72JAuVwOoxBxzgE0sLGd0ritVsk+/JXRDr26ybGJbhZEN+tkXRAU2Cnm?=
 =?iso-8859-1?Q?xCmwHQ0TvbcghbmKc9DbomSjS/eEYZ11l6flz+OOdbNmONlF4Wdch70Ez9?=
 =?iso-8859-1?Q?hAuBI4xS6QoK4NT82eZLwXgTKlK0Tk0CaO8KIzWd+S1985CkI/tEsDb8fV?=
 =?iso-8859-1?Q?+6HtlWLn8kADSFsYJEQCGAnhaxHwtJDtU5ymLVwhwwS9GJIA4EhHL1Fvd7?=
 =?iso-8859-1?Q?8xGOIiKeiZvl2BbEp6qpHaz7xavNqzBVimv9m4MrILYowY2o9yJvY9ASDG?=
 =?iso-8859-1?Q?KowQFpKEASrJA76O6oKqFI4dF9qUrkIUkrNnVafpVbubcjKf+Ik4wV4ds/?=
 =?iso-8859-1?Q?s5bXRVoVfVRbkSjODhnwspJ7s+K4j55cwJdKTRSGFKghSO36fIJWIHixdx?=
 =?iso-8859-1?Q?OnP0yXvufag8fvUnZpilmjFzKQIXtnllUl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f37179a-269f-449d-4ada-08dc609cb84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 18:15:40.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pM+AtIs5s2Qg1rOGuEnygd/lupUdzzZy96k/2Yk33tO/K18V/vraLwbgWgpWzN+m7RO700ThIpRjPxOcJklQng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3296



> -----Original Message-----
> From: Francois <rigault.francois@gmail.com>
> Sent: Sunday, April 14, 2024 1:15 PM
> To: linux-hyperv@vger.kernel.org
> Subject: Nic flaps for 1 minute when reconnecting
>=20
> [You don't often get email from rigault.francois@gmail.com. Learn why
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> hello (I'm not subscribed to this list)
> I run a few Linux machines on Hyper-V on my Windows 10 laptop
> and notice that, from time to time, they lose the network for about 1
> minute
> (briefly coming back up then down again)
> I don't know what the actual trigger is, but I believe the "flapping"
> is caused by the delay linked to "LINKCHANGE_INT".
>=20
> Following is how I reproduce, the logs on Linux side, Windows side,
> and patch I am running to avoid this.
>=20
> I manage to reproduce this way: in Windows, run the "Services" app,
> right click the "Internet Connecting Sharing (ICS)" service, choose
> restart...
>=20
> on my VM I read these logs:
>=20
> ----
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream NetworkManager[1013]: <trace>
> [1703407173.1367] platform-linux: event-notification: RTM_NEWLINK,
> flags 0, seq 0: 2: enx00155d343101 <UP;broadcast,multicast,up> mtu
> 1500 arp 1 ethernet? not-init addrgenmode none>d=E9c. 24 09:39:33 stream
> NetworkManager[1013]: <debug> [1703407173.1368] platform:
> (enx00155d343101) signal: link changed: 2: enx00155d343101
> <UP;broadcast,multicast,up> mtu 1500 arp 1 ethernet? init addrgenmode
> none addr 00:15:5D:34:3>d=E9c. 24 09:39:33 stream NetworkManager[1013]:
> <trace> [1703407173.1368] l3cfg[17837add519934e3,ifindex=3D2]: emit
> signal (platform-change, obj-type=3Dlink, change=3Dchanged, obj=3D2:
> enx00155d343101 <UP;broadcast,multicast,up> mtu 1500 arp 1 >d=E9c. 24
> 09:39:33 stream kernel: hv_netvsc 9538b269-5961-4c95-aa0b-b2994c468668
> enx00155d343101: RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf
> len 0, buf offset 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream NetworkManager[1013]: <debug>
> [1703407173.1368] device[cf06ffc422da9956] (enx00155d343101): queued
> link change for ifindex 2
> d=E9c. 24 09:39:33 stream NetworkManager[1013]: <debug>
> [1703407173.1371] device[cf06ffc422da9956] (enx00155d343101): carrier:
> link disconnected (deferring action for 6000 milliseconds)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
> 0)
> d=E9c. 24 09:39:33 stream kernel: hv_netvsc
> 9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
> RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
> offset 12)
> d=E9c. 24 09:39:37 stream NetworkManager[1013]: <trace>
> [1703407177.2456] platform-linux: event-notification: RTM_NEWLINK,
> flags 0, seq 0: 2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
> ethernet? >d=E9c. 24 09:39:37 stream NetworkManager[1013]: <debug>
> [1703407177.2457] platform: (enx00155d343101) signal: link changed: 2:
> enx00155d343101 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
> mtu 1500 arp 1 ethernet? init addrgenmod>d=E9c. 24 09:39:37 stream
> NetworkManager[1013]: <trace> [1703407177.2457]
> l3cfg[17837add519934e3,ifindex=3D2]: emit signal (platform-change,
> obj-type=3Dlink, change=3Dchanged, obj=3D2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running>d=E9c. 24 09:39:37 stream
> NetworkManager[1013]: <debug> [1703407177.2458]
> device[cf06ffc422da9956] (enx00155d343101): queued link change for
> ifindex 2
> d=E9c. 24 09:39:37 stream NetworkManager[1013]: <info>
> [1703407177.2460] device (enx00155d343101): carrier: link connected
> d=E9c. 24 09:39:37 stream NetworkManager[1013]: <debug>
> [1703407177.2461] device[cf06ffc422da9956] (enx00155d343101): carrier:
> link disconnected (canceling deferred action)
> d=E9c. 24 09:39:37 stream NetworkManager[1013]: <trace>
> [1703407177.2462] ethtool[2]: ETHTOOL_GSET, enx00155d343101: success
> d=E9c. 24 09:39:39 stream NetworkManager[1013]: <trace>
> [1703407179.2935] platform-linux: event-notification: RTM_NEWLINK,
> flags 0, seq 0: 2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
> ethernet? >d=E9c. 24 09:39:39 stream NetworkManager[1013]: <debug>
> [1703407179.2936] platform: (enx00155d343101) signal: link changed: 2:
> enx00155d343101 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
> mtu 1500 arp 1 ethernet? init addrgenmod>d=E9c. 24 09:39:39 stream
> NetworkManager[1013]: <trace> [1703407179.2936]
> l3cfg[17837add519934e3,ifindex=3D2]: emit signal (platform-change,
> obj-type=3Dlink, change=3Dchanged, obj=3D2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running>d=E9c. 24 09:39:39 stream
> NetworkManager[1013]: <debug> [1703407179.2936]
> device[cf06ffc422da9956] (enx00155d343101): queued link change for
> ifindex 2
> d=E9c. 24 09:39:39 stream NetworkManager[1013]: <trace>
> [1703407179.2936] platform-linux: event-notification: RTM_NEWLINK,
> flags 0, seq 0: 2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
> ethernet? >d=E9c. 24 09:39:41 stream NetworkManager[1013]: <trace>
> [1703407181.3417] platform-linux: event-notification: RTM_NEWLINK,
> flags 0, seq 0: 2: enx00155d343101 <UP;broadcast,multicast,up> mtu
> 1500 arp 1 ethernet? not-init addrgenmode none>d=E9c. 24 09:39:41 stream
> NetworkManager[1013]: <debug> [1703407181.3418] platform:
> (enx00155d343101) signal: link changed: 2: enx00155d343101
> <UP;broadcast,multicast,up> mtu 1500 arp 1 ethernet? init addrgenmode
> none addr 00:15:5D:34:3>d=E9c. 24 09:39:41 stream NetworkManager[1013]:
> <trace> [1703407181.3418] l3cfg[17837add519934e3,ifindex=3D2]: emit
> signal (platform-change, obj-type=3Dlink, change=3Dchanged, obj=3D2:
> enx00155d343101 <UP;broadcast,multicast,up> mtu 1500 arp 1 >d=E9c. 24
> 09:39:41 stream NetworkManager[1013]: <debug> [1703407181.3418]
> device[cf06ffc422da9956] (enx00155d343101): queued link change for
> ifindex 2
> d=E9c. 24 09:39:41 stream NetworkManager[1013]: <debug>
> [1703407181.3424] device[cf06ffc422da9956] (enx00155d343101): carrier:
> link disconnected (deferring action for 6000 milliseconds)
> d=E9c. 24 09:39:45 stream NetworkManager[1013]: <trace>
> [1703407185.4376] platform-linux: event-notification: RTM_NEWLINK,
> flags 0, seq 0: 2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
> ethernet? >d=E9c. 24 09:39:45 stream NetworkManager[1013]: <debug>
> [1703407185.4377] platform: (enx00155d343101) signal: link changed: 2:
> enx00155d343101 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
> mtu 1500 arp 1 ethernet? init addrgenmod>d=E9c. 24 09:39:45 stream
> NetworkManager[1013]: <trace> [1703407185.4377]
> l3cfg[17837add519934e3,ifindex=3D2]: emit signal (platform-change,
> obj-type=3Dlink, change=3Dchanged, obj=3D2: enx00155d343101
> <UP,LOWER_UP;broadcast,multicast,up,running>d=E9c. 24 09:39:45 stream
> NetworkManager[1013]: <debug> [1703407185.4377]
> device[cf06ffc422da9956] (enx00155d343101): queued link change for
> ifindex 2
> d=E9c. 24 09:39:45 stream NetworkManager[1013]: <info>
> [1703407185.4380] device (enx00155d343101): carrier: link connected
> d=E9c. 24 09:39:45 stream NetworkManager[1013]: <debug>
> [1703407185.4381] device[cf06ffc422da9956] (enx00155d343101): carrier:
> link disconnected (canceling deferred action)
> d=E9c. 24 09:39:45 stream NetworkManager[1013]: <trace>
> [1703407185.4382] ethtool[2]: ETHTOOL_GSET, enx00155d343101: success
> ...
> d=E9c. 24 09:39:53 stream NetworkManager[1013]: <info>
> [1703407193.6298] device (enx00155d343101): carrier: link connected
> ...
> d=E9c. 24 09:40:01 stream NetworkManager[1013]: <info>
> [1703407201.8219] device (enx00155d343101): carrier: link connected
> ...
> d=E9c. 24 09:40:10 stream NetworkManager[1013]: <info>
> [1703407210.0138] device (enx00155d343101): carrier: link connected
> ...
> d=E9c. 24 09:40:18 stream NetworkManager[1013]: <info>
> [1703407218.2059] device (enx00155d343101): carrier: link connected
> ----
>=20
> while Windows events show:
>=20
> ----
> Get-WinEvent -LogName  Microsoft-Windows-Hyper-V-VmSwitch-Operational
> -MaxEvents 50 -FilterXPath "*[System[Level<5]]"
>=20
>    ProviderName: Microsoft-Windows-Hyper-V-VmSwitch
>=20
> TimeCreated                      Id LevelDisplayName Message
> -----------                      -- ---------------- -------
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Connected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (Nic Disconnected) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> 24/12/2023 09:39:33             220 Information      Status change
> (IPSEC Disable) sent to Nic
> 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> ----
>=20
> It seems there is a quick succession of disconnections and
> reconnections.
> On the kernel side there seems to be a delay of 2s imposed for each of
> these, so I applied this patch, as a proof of concept, to workaround
> the issue:
>=20
> ----
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -39,7 +39,7 @@
>=20
>  #define RING_SIZE_MIN  64
>=20
> -#define LINKCHANGE_INT (2 * HZ)
> +#define LINKCHANGE_INT (2 * HZ / 100)
>  #define VF_TAKEOVER_INT (HZ / 10)
>=20
>  static unsigned int ring_size __ro_after_init =3D 128;
> ----
>=20
> which works great. Do you know if there is a real need for a 2s delay
> for link change?
> I experienced this issue on all the Linux VMs I booted on my laptop,
> although I'm primarily running Centos Stream9.
> (I reported the issue there without much luck
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fissue=
s.
> redhat.com%2Fbrowse%2FRHEL-
> 20224&data=3D05%7C02%7Chaiyangz%40microsoft.com%7Ce5b6421762ec4be868ca08d=
c5
> ca66de1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638487117095524688%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DoxfowwcsFjInwAnfTQt6PNMgz8ItJKCq%2F=
BV
> Cpv8D4SA%3D&reserved=3D0, ticket is private)
>=20
> Thanks!
> Francois

The 2 seconds delay is necessary for the upper layers, like link_watch=20
infrastructure, and userspace to handle the status change properly.

See the following patch for more details:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D27a70af3f4cf633a1b86c0ac7b426e2fe16ad2e5

author	Vitaly Kuznetsov <vkuznets@redhat.com>	2015-11-27 11:39:55 +0100
committer	David S. Miller <davem@davemloft.net>	2015-12-01 14:58:07 -0500
commit	27a70af3f4cf633a1b86c0ac7b426e2fe16ad2e5 (patch)
tree	e4dc499878da293844034dc90d2894189ae2bda6
parent	77b75f4d8cf105b599beef38724f8171e557919d (diff)
download	net-27a70af3f4cf633a1b86c0ac7b426e2fe16ad2e5.tar.gz
hv_netvsc: rework link status change handling
There are several issues in hv_netvsc driver with regards to link status
change handling:
- RNDIS_STATUS_NETWORK_CHANGE results in calling userspace helper doing
  '/etc/init.d/network restart' and this is inappropriate and broken for
  many reasons.
- link_watch infrastructure only sends one notification per second and
  in case of e.g. paired disconnect/connect events we get only one
  notification with last status. This makes it impossible to handle such
  situations in userspace.

Redo link status changes handling in the following way:
- Create a list of reconfig events in network device context.
- On a reconfig event add it to the list of events and schedule
  netvsc_link_change().
- In netvsc_link_change() ensure 2-second delay between link status
  changes.
- Handle RNDIS_STATUS_NETWORK_CHANGE as a paired disconnect/connect event.


Thanks,
- Haiyang


