Return-Path: <linux-hyperv+bounces-200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA2A7ABA57
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 7602E1F2343E
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179544462;
	Fri, 22 Sep 2023 20:03:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36647341
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 20:03:29 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD51A2;
	Fri, 22 Sep 2023 13:03:28 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3adc3d94f66so1657979b6e.1;
        Fri, 22 Sep 2023 13:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695413007; x=1696017807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92vwJf3WLmkpUBPfM1uX6jdmCsJTt9zpYit4o1iVPi8=;
        b=rFYOk1ch88uOvZb8zJLWalshSsUk+B77cqUWWub3URXfej/Ap/PzaeN5hzPoxeRt60
         Iexvc93zFzzk/c6VhD/cS9z8EVFKKYdnxEu0NDVqjRwryMZv435lbU01lp647pPuNAYZ
         t1j/o2Kc0xv/KSGN1TF1TZHgKvZ7zsNfXX2Tsy/TP8wYSUaBM0SUiv/zkMjX+oAkift2
         zhkpPX2GA635YnCIEkgLarnszAbAy1V2AUw9NBI3eMti/Bp3e/JCEVm/0TWeEOBeCJ2Q
         aUqnL7gFW32lswJevXSB4Q3sZzec/I1Ib13IBIh6KMWqkVkrJVcyMJOJ8Axz5yk36T91
         n7Vg==
X-Gm-Message-State: AOJu0YyYW3mEy5UK0ix5lMM1sksEryKmSVOiQTnsMgIixbRkm+sUDrdH
	QPRe3BhmRGR0R1J+QLoGjKg=
X-Google-Smtp-Source: AGHT+IEP3JVa7YW6iKvp3c2447aJv58pC9gBEASQVTZuq+rvJLqoI+1fmX0Z9I0z5RQGrE60EI+KSw==
X-Received: by 2002:a05:6808:4d4:b0:3a7:35af:bbc0 with SMTP id a20-20020a05680804d400b003a735afbbc0mr664405oie.54.1695413007358;
        Fri, 22 Sep 2023 13:03:27 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id fe20-20020a056a002f1400b0068fadc9226dsm3614729pfb.33.2023.09.22.13.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 13:03:26 -0700 (PDT)
Date: Fri, 22 Sep 2023 20:02:43 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZQ3y47GDfhjf23Rh@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> Add mshv, mshv_root, and mshv_vtl modules:
> 
> Module mshv is the parent module to the other two. It provides /dev/mshv,
> plus some common hypercall helper code. When one of the child modules is
> loaded, it is registered with the mshv module, which then provides entry
> point(s) to the child module via the IOCTLs defined in uapi/linux/mshv.h.
> 
> E.g. When the mshv_root module is loaded, it registers itself, and the
> MSHV_CREATE_PARTITION IOCTL becomes available in /dev/mshv. That is used to
> get a partition fd managed by mshv_root.
> 
> Similarly for mshv_vtl module, there is MSHV_CREATE_VTL, which creates
> an fd representing the lower vtl, managed by mshv_vtl.
> 
> Module mshv_root provides APIs for creating and managing child partitions.
> It defines abstractions for partitions (vms), vps (vcpus), and other things
> related to running a guest. It exposes the userspace interfaces for a VMM
> to manage the guest.
> 
> Module mshv_vtl provides VTL (Virtual Trust Level) support for VMMs. In
> this scenario, the host kernel and VMM run in a higher trust level than the
> guest, but within the same partition. This provides better isolation and
> performance.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

As far as I can tell, all my comments from the previous version are
addressed. I believe Saurabh and Boqun's comments are addressed, too.

The code looks good to me, so:

Acked-by: Wei Liu <wei.liu@kernel.org>

I will wait for some time for others to chime in, just in case the
community has more comments.

