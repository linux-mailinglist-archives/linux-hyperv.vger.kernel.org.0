Return-Path: <linux-hyperv+bounces-5392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62622AACC2C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852661C03FAA
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDCC27F73D;
	Tue,  6 May 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmI38z2P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AA1DE2D6;
	Tue,  6 May 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552374; cv=none; b=EkC38BRsqImN/rHlbyqtYFXlGf/8d8QCDmyaWtC5OSIM1CPnhnHJQO5Caqzmtuz/dTPfp5nokrA10VvznEV/gEcNdX/iSo+Crke8Bdwrinv2aHls+8fhS8i6KewCmVwHjWqJ6rVfRGqn3IQHXvOXKr9sG1Hc2TH23qmFjWgUtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552374; c=relaxed/simple;
	bh=UMFkBWv7qRD8bW9aXzn0NDPBLTJV6Ud3ZL7mJrUPeqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwaynqDl+o4yz1djnc3xkcZ5Qm2907hMhxmhRoh9qBEMxetsqwdV7Ri1du85ArT0nvE60yc8T2C3DO/Tr+vf6ZLxb64+vT9LD09kXRktAiW+AMiKQd/QZGMuruHpIoie0bU3nXHlmhmigfRzXNGjwEHRrvo2R+FzeJi7N3ykVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmI38z2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDEBC4CEF5;
	Tue,  6 May 2025 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746552374;
	bh=UMFkBWv7qRD8bW9aXzn0NDPBLTJV6Ud3ZL7mJrUPeqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WmI38z2PFndQwKFr24GsvaYfg0l51lIK2c80s42vZEV93IZtiDGmFCeoeUHJhkqjT
	 rq/cINc1Ku7YS7Lsna7B6EEs3WRnaTg4ADxYxZ8fcOqIPFub9mRvOOEJX8ngAmPxnT
	 nd4mFMC+DOqUUzzpUNQFAN7nRo0vrvrGKwpRfiBw7nezujWEmAfc8ChvXWg+c9f6zB
	 Dd7ptMrrxbUOb0J6APajMsGKkSUNGPt56tRpt2hIGhImzE2s5AlB4oz3yqymt/uZHm
	 GaReDoenNdzj+D0eLnFri44Pjx/19GhfYMVoDFbDYnGaF4FyiuM/6BwBc+VQRk1cvn
	 dKDLthWmDrmvA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-604ad0347f5so1399603eaf.2;
        Tue, 06 May 2025 10:26:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUabmKbCieebhg65h2HZO6pXZqb7EE7qDdMHPkFvwRAlBMuNAtOnLuSbEZSprSfsmoTvgmlXjIH+X8psg==@vger.kernel.org, AJvYcCUp7j6293hCuvAc7TOMqTAd8GWQj01xb1hTCsspweTc21f8mm2MxZLknEBVW7DJsoBPqAl7WhonxB9C@vger.kernel.org, AJvYcCUvCM3lgxEE8sifMCaUUgOA0JgyFgNZIAzKdfGIFuGBRxuou+JHs+lrsh/CU1NbQiteHIdok+CMu5+cBhc4@vger.kernel.org, AJvYcCVlZuigAdEe77Ook/5SdOuw7SZ5ViUek7a6Qb9Maw1xg1kxbdmPu6ik7K/SMmKWTYUzqwO2c2ElSk5nvTS3@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkTxCrbp1RaHJ/PXJsbTX/C6AJIZzl84fhLqWxCeTnKLmj9H2
	voZvGuupVcI4ESrEjUT65PaCZ+XXEPdRTqVDhC0EiwnXcGcGlkuNbphB8ll8wLaT83SmocZdRVx
	Nj9BVecSDpmHBhtTXp4R8J7/bSn4=
X-Google-Smtp-Source: AGHT+IFkmlMTEuWESqaLnJeY5ohB2LfqsG10ssB1VE80OUaJLJaw48V3A3/jUfrqL8UR0k470ufguSdRn5ahDVoR12A=
X-Received: by 2002:a05:6870:56aa:b0:2c2:4e19:1cdf with SMTP id
 586e51a60fabf-2db5c07fc1fmr84473fac.25.1746552373247; Tue, 06 May 2025
 10:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0h_QcH72COEU-cnHUMfXj2grHv1EoLuBJnxm7_AeRteWw@mail.gmail.com> <20250506053726.GF25533@ranerica-svr.sc.intel.com>
In-Reply-To: <20250506053726.GF25533@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 May 2025 19:26:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gctkVZUs1SrzQtezmfMuMfbrAJ4+DTLgaQB=pMc8_hvg@mail.gmail.com>
X-Gm-Features: ATxdqUF-7NBHDlWjglj-HucJrGpkm_viZYiT0uvxHH2Buc_c3FoPAXf1SFixwh8
Message-ID: <CAJZ5v0gctkVZUs1SrzQtezmfMuMfbrAJ4+DTLgaQB=pMc8_hvg@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpboot.c
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:32=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, May 05, 2025 at 12:03:13PM +0200, Rafael J. Wysocki wrote:
> > On Sat, May 3, 2025 at 9:10=E2=80=AFPM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmwar=
e that
> > > it wants to boot a secondary CPU using a mailbox as described in the
> > > Multiprocessor Wakeup Structure of the ACPI specification.
> > >
> > > The wakeup mailbox does not strictly require support from ACPI.
> >
> > Well, except that it is defined by the ACPI specification.
>
> That is true.
>
> >
> > > The platform firmware can implement a mailbox compatible in structure=
 and
> > > operation and enumerate it using other mechanisms such a DeviceTree g=
raph.
> >
> > So is there a specification defining this mechanism?
> >
> > It is generally not sufficient to put the code and DT bindings
> > unilaterally into the OS and expect the firmware to follow suit.
> >
>
> This mechanism is described in the section 4.3.5 of the Intel TDX
> Virtual Firmware Design Guide [1], but it refeers to the ACPI
> specification for the interface.

Yes, it does.

> > > Move the code used to setup and use the mailbox out of the ACPI
> > > directory to use it when support for ACPI is not available or needed.
> >
> > I think that the code implementing interfaces defined by the ACPI
> > specification is not generic and so it should not be built when the
> > kernel is configured without ACPI support.
>
> Support for ACPI would not be used on systems describing hardware using
> a DeviceTree graph. My goal is to have a common interface that both
> DT and ACPI can use. I think what is missing is that common interface.

I get the general idea. :-)

> Would it be preferred to have a separate implementation that is
> functionally equivalent?

Functionally equivalent on the OS side, that is.

It would be better, but honestly I'm not sure if this is going to be
sufficient to eliminate the dependency on the ACPI spec.  It is just
as you want the firmware to implement this tiny bit of the ACPI spec
even though it is not implementing the rest of it.

> [1]. https://cdrdv2-public.intel.com/733585/tdx-virtual-firmware-design-g=
uide-rev-004-20231206.pdf

