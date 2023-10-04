Return-Path: <linux-hyperv+bounces-467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05757B884C
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 20:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 208981C20442
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA31D68D;
	Wed,  4 Oct 2023 18:14:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC71D6A1
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Oct 2023 18:14:45 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE6AD;
	Wed,  4 Oct 2023 11:14:43 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57ba2cd3507so48374eaf.2;
        Wed, 04 Oct 2023 11:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443282; x=1697048082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nCGy29qXBi+ptXe1DWiTKziKMJYl0S7yqrhbrtMgRk=;
        b=Yg4jfZB1D6M+H8/YJER0nPtdjX+UDnUHAmgqeIG4xHbo8XhudT/PB4ZzXBSnJ+4V2N
         hBepuB6cVH07ehtsJ/+dVkaIuG19wqlw2vKY8F3LzyA0RvvAojxDOUVuDfuVbftIHgI1
         j5acvbqZuzUm6l1e8DVxzMqvrPLllwCvRZDM4vtHLAgjbEsH3Y2QJ3tQnvS4FMCGrWbl
         JGeqcq4+qZR/8KeI+vDd/zm9mpDsGc+ebxwuuvW//oXq5XBhC2nbvWvk4l7tvds812X+
         3Asptx8pW7RbbxOcCnpzOJUjXKgjbwwYQAbmMdSqQFwtjXrYIboZfXrYmT+/gVWDkY47
         TXPQ==
X-Gm-Message-State: AOJu0YxLhTAoveFyYSijaSUb7saTLirl2owgHE3oYhhT+8AzBazI04wU
	dopDWaxWvwr4TcgNFe4WFxU=
X-Google-Smtp-Source: AGHT+IG7EHbaeeYSQWuYVxJewBVTKh+hSRaSfAIMnjP6jTwYH5NMi2y1YeijxB0WtRbsPtXrqTnwuw==
X-Received: by 2002:a05:6358:5e12:b0:139:d5b9:87d3 with SMTP id q18-20020a0563585e1200b00139d5b987d3mr2311233rwn.5.1696443282278;
        Wed, 04 Oct 2023 11:14:42 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c627413e87sm4013296plz.290.2023.10.04.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:14:41 -0700 (PDT)
Date: Wed, 4 Oct 2023 18:14:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <ZR2rkNYnQds1MGZ0@liuwe-devbox-debian-v2>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <ZRyj5kJJYaBu22O3@liuwe-devbox-debian-v2>
 <2023100458-confusing-carton-3302@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100458-confusing-carton-3302@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Greg

On Wed, Oct 04, 2023 at 08:11:13AM +0200, Greg KH wrote:
> On Tue, Oct 03, 2023 at 11:29:42PM +0000, Wei Liu wrote:
> > > > > > diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..9bcbb7d902b2
> > > > > > --- /dev/null
> > > > > > +++ b/include/uapi/hyperv/hvgdk.h
> > > > > > @@ -0,0 +1,41 @@
> > > > > > +/* SPDX-License-Identifier: MIT */
> > > > > 
> > > > > That's usually not a good license for a new uapi .h file, why did you
> > > > > choose this one?
> > > > > 
> > > > 
> > > > This is chosen so that other Microsoft developers who don't normally
> > > > work on Linux can review this code.
> > > 
> > > Sorry, but that's not how kernel development is done.  Please fix your
> > > internal review processes and use the correct uapi header file license.
> > > 
> > > If your lawyers insist on this license, that's fine, but please have
> > > them provide a signed-off-by on the patch that adds it and have it
> > > documented why it is this license in the changelog AND in a comment in
> > > the file so we can understand what is going on with it.
> > > 
> > 
> > We went through an internal review with our legal counsel regarding the
> > MIT license. We have an approval from them.
> > 
> > Let me ask if using something like "GPL-2.0 WITH Linux-syscall-note OR
> > MIT" is possible.
> 
> That marking makes no sense from a legal point of view, please work with
> your lawyers as it seems they do not understand license descriptions
> very well :(
> 

Do you mean "GPL-2.0 WITH Linux-syscall-note OR MIT" doesn't make sense?

Why is that? I see that in various UAPI headers.

include/uapi/drm/lima_drm.h:1:/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
include/uapi/linux/io_uring.h:1:/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
include/uapi/linux/kfd_sysfs.h:1:/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
include/uapi/linux/rkisp1-config.h:1:/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR MIT) */
include/uapi/linux/wireguard.h:1:/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
include/uapi/xen/evtchn.h:1:/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR MIT) */
include/uapi/xen/gntdev.h:1:/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR MIT) */
include/uapi/xen/privcmd.h:1:/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR MIT) */

Thanks,
Wei.

> thanks,
> 
> greg k-h

