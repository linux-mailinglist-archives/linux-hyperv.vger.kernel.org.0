Return-Path: <linux-hyperv+bounces-6553-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE6B29C5A
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC47E18974F4
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610043009F0;
	Mon, 18 Aug 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aze4Y5K8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89DA3009FC
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506077; cv=none; b=L+gfsELggRydtXI8U6hLk+PuXyRgzw5jPkq+DdAfN+zTO8ZemgYEFLVhxT6E/sFsvFcvLK3O1jl8yPSKMkgyaTuy7VXIm5YfEU4soVBMo8DEOplW8EfM1/qtabIQRtp9oL8oZE1GimXfVA175ekN2vSQVNlD/g/He+Gd4N7m8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506077; c=relaxed/simple;
	bh=YKnYr324eUUhj+QvrdVq/1e4Gz0w8e7EzwXqGsvWiSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNW4EwrvVMgmnMnMlr2LrjNVwsg59HvbwRf6D/1wPzmvAXmLTMlVcU/6u4NDlCoTR9nIdZ9V9KzhT/FUZzwSvNI9vs3mWPZ/7dQsPOmXF35jjRcoVChCMAxw6KgWO81Of+3Pe/S55dEbgFYEVw/ahG9gv3n2IVnE8SF9fp/pvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aze4Y5K8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7VVBx001078
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 08:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YKnYr324eUUhj+QvrdVq/1e4Gz0w8e7EzwXqGsvWiSk=; b=Aze4Y5K8XQlzwnRF
	KS2Vkdxd7n2qp5VewK8A0a6hxTVqbzMOozD5we+cTVDCFI/JgzI4KiILotlO/UDT
	5nep91KwnnHHqgiAzY1H8M3CWe1zTEmZYyWHunj4Ox0D6WSd5grZgkLGRwPg1VDC
	AV7KF5nJZeWoctIPiE0ufDcHdCnyV7xMUGfrwbXbmIslahVPylvI9zmR1/9esOJY
	AFEx5vpmQjcRyyhWxPm+CoJZ5aqsnT0c5D/yh/yGTOu1npeEZWylk1LpzGMfAn+L
	zrROeF6fcgqEzADtHMgH4NoIVLArFoA6z69DOF0yue7AxwnGRTjpFvxh/tfVJGe1
	wi1rZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7uxmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 08:34:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f440f0so41254565ad.0
        for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 01:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506073; x=1756110873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKnYr324eUUhj+QvrdVq/1e4Gz0w8e7EzwXqGsvWiSk=;
        b=gr9oVjZnq9oWXPx387dRWXivxBCKGu5diw6rDhV8oE6Hyoa2rmYRiFEnuVe0KmDU7s
         JmFqzHaVoLKznn2st0J6UPt9jnHqQAVgXQVHAjX3KlbkUg1Q4sTo26O/sA+XHhsvC6Fk
         7x1MLXQGHWwVQkP9HAR5ZFgQB5MHOIlgXaaLAa5D5ts9anyyttefGovVDOIRxq91WnhF
         ZrQUzMRyGSFVisf8IG6DUzcBlvcR+YDuOcWfuUGyJdueoJNR5XA6E40MbpcYePUoPwpC
         0tbmEacoFfZj2n1URYgYrD241nAXkPbFz+Z6GczcK8qofQX1Zkt5nlfPBn/SafcRaYBO
         fZbg==
X-Forwarded-Encrypted: i=1; AJvYcCVKRY5R2ECRAAdq0Vk9bAz7V/bP37HAQ0Gbv157SO34SlU98aKGY7aRCjwy6GG3ng6aG0BVZ8nuiq7RQew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxo5X9HpR8w6/r4nnKQfiOYlrQDFnIDr2rgW+WK/MJOSt+qEo2
	9LJIfdV58nqtRGVMFdTYVeUo1c6qvtHaf97BHjir4B4SDGswFiFJ+ppjdC566aQm1u8Vm4CGITx
	Zu9cUBXh8CWDJuDFzPUrefN3kF9xyjbbeYHNJnxRBimyPr15HmJu+lEhOLtk41PRv1lul42InRG
	fTsPPaB23bDYCy5cz2ZzCWR/rTa/X9z4+RJlY7vyMqQg==
X-Gm-Gg: ASbGncsbWdclMebL42xsoYNDT33wbvH5iFxsXPzNgrOsfOqflk4FWhsD8i/2BVqy6ow
	+SmtkImHbwcDWK8v+CPPABFxeV1O5xdEohYc7gKKdiAb/fOQqcaTSJDs5fL4hF0Hih4NNPoiciV
	dviV+c6jRTDTzkFAoN8DUBow==
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-2446d745130mr162002075ad.22.1755506072929;
        Mon, 18 Aug 2025 01:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0iaKkOx5HF+G/2fDa+4Vn+rw7qYZXEvgZcGmIZ96t7UkZ4Y6iVl499qKwZ/lWHVbWQiw75ZkO9MQbjWLb6hM=
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id
 d9443c01a7336-2446d745130mr162001485ad.22.1755506072460; Mon, 18 Aug 2025
 01:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-numa_memblks-v1-1-9eb29ade560a@oss.qualcomm.com>
 <d7cdb65d-c241-478c-aa01-bc1a5f188e4f@redhat.com> <CALzOmR0C8BFY+-u-_aprVeAhq4uPOQa+f2L5m+yZH+=XZ2cv_w@mail.gmail.com>
 <63082884-1fe2-4740-8e6a-e1d06aa5e239@redhat.com>
In-Reply-To: <63082884-1fe2-4740-8e6a-e1d06aa5e239@redhat.com>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:04:20 +0530
X-Gm-Features: Ac12FXzX5PzSlv6roYThUOo89xclaREe5qOUHnsYKt7fIrY-t8kJ9YEJL5m2flQ
Message-ID: <CALzOmR0MJv8EgPiFTvvbdkk8H_0BEDA4QQXKyqRPOCwwzGwjsw@mail.gmail.com>
Subject: Re: [PATCH] mm/numa: Rename memory_add_physaddr_to_nid to memory_get_phys_to_nid
To: David Hildenbrand <david@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX/TuGyqgq4+Pt
 +9l/ujQtfiIU80FtPhZxYyCywrw/sWorGArgVXh6Ibvi7e3MkTMn1k4oprpNEWjDmkVJYzV/2iL
 bb0OsB9CM84yVGskGbY9ceX4+6ZOWtT5YZAr9/hnRPkH7WwLCKtKdxS8AQoA6dS093+LOjXUWkL
 tlQXgO7GbDBBDc2CjckB7mtrq5ca1IH1jwpgoejCi1BDf598diSjYuilVE+n5X2DGfag6qvKwHx
 XtytEwroI8scrMie3kJ/ASnYRRf/G7euV8IcmD9kqEKvLsJdCiCcrSaQj52X11S4p06Y1gr8Xbx
 PGxmJHFemWGKVqg24h7JGkIdnAVmnwA/jVPa0+tJNxlEidL/Eqr9b9yGXRDCCfKMQ9IUZDmnqAl
 0C6kT33T
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2e59a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AFlVVsuRyXfiT6IdkpsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Xqh3nL3GmaffDX_cn-atuk0gQucUQk9E
X-Proofpoint-ORIG-GUID: Xqh3nL3GmaffDX_cn-atuk0gQucUQk9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

On Mon, Aug 18, 2025 at 2:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.08.25 10:27, Pratyush Brahma wrote:
> > On Mon, Aug 18, 2025 at 12:29=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 18.08.25 08:41, pratyush.brahma@oss.qualcomm.com wrote:
> >>> From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> >>>
> >>> The function `memory_add_physaddr_to_nid` seems a misnomer.
> >>> It does not to "add" a physical address to a NID mapping,
> >>> but rather it gets the NID associated with a given physical address.
> >>
> >> You probably misunderstood what the function is used for: memory hotpl=
ug
> >> aka "memory_add".
> > Thanks for your feedback. I get the part about memory hotplug here but
> > using memory_add still seems a little odd as it doesn't truly reflect
> > what this api is doing.
> > However, I agree that my current suggestion
> > may not be the perfect choice for the name, so I'm open to suggestions.
> >
> > Perhaps, something like "memory_add_get_nid_by_phys" may work here?
>
> I don't think this name is really any better and worth the churn :(
>
Sure. Thanks for taking a look. Will drop this.
> --
> Cheers
>
> David / dhildenb
>
Thanks & Regards
Pratyush

