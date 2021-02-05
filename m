Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB03115E0
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 23:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhBEWoM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 17:44:12 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:38802 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhBENGb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 08:06:31 -0500
Received: by mail-oo1-f52.google.com with SMTP id y72so1584753ooa.5;
        Fri, 05 Feb 2021 05:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zebLqAyquoHLSHUIiikHXZ2kyJyvLp0C6IWdVIP3/DY=;
        b=rVkfciYGCGvLy3tOUuFsj1ucLDAMY/ALk44YYn0knLS4ax88oJFXFLwIbvTPRY1wXo
         MIkBSGIbU/bl04Iu20yw2WRhtzlZYik5/tktu4wjVSkhh9M+oHQo2uC2YVbVYJQEVwnN
         vEpveuoTsK75UUtXvrQZswI2Lsl5jHShhzgaVtUttd1dVsMG5AVAArPBMaA8UzwkxQGa
         Uo5mCI1EtVtgw904uJRwunTRApozkbiUfHszDnH2uTAdx+zH/TtpU6Bj9r9aILC/xXj7
         fYm84yfjMr6QWqMAK5fmFmgNuTp526wI3mDePMEyt3jigxA2zaVh2e1qZJApxKOto1WP
         DGPw==
X-Gm-Message-State: AOAM5318mPfWt2vl4uXgVKzNAn+yeqCvzFIONGXkp5EmRKZC4qK0eUUM
        VpZhZqa8S1KyqYzYj/FumRLTtHNqJoTowqr9wu4=
X-Google-Smtp-Source: ABdhPJx6NeTAwt85sUv2RX3A/gu3yohSf5WM8vovVK+5JVJXvAw3mZpKQhGcOvPxeXBgAbXd2TZ2FWfqFJJZxAu1BZw=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr3360258ooi.44.1612530350081;
 Fri, 05 Feb 2021 05:05:50 -0800 (PST)
MIME-Version: 1.0
References: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 14:05:36 +0100
Message-ID: <CAJZ5v0jRgeAsyZXpm-XdL6GCKWk5=yVh1s4fZ3m0++NJK-gYBg@mail.gmail.com>
Subject: Re: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Dec 12, 2020 at 2:22 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> Hi all,
> It looks like Linux can hibernate even if the system does not support the ACPI
> S4 state, as long as the system can shut down, so "cat /sys/power/state"
> always contains "disk", unless we specify the kernel parameter "nohibernate"
> or we use LOCKDOWN_HIBERNATION.
>
> In some scenarios IMO it can still be useful if the userspace is able to detect
> if the ACPI S4 state is supported or not, e.g. when a Linux guest runs on
> Hyper-V, Hyper-V uses the virtual ACPI S4 state as an indicator of the proper
> support of the tool stack on the host, i.e. the guest is discouraged from
> trying hibernation if the state is not supported.
>
> I know we can check the S4 state by 'dmesg':
>
> # dmesg |grep ACPI: | grep support
> [    3.034134] ACPI: (supports S0 S4 S5)
>
> But this method is unreliable because the kernel msg buffer can be filled
> and overwritten. Is there any better method? If not, do you think if the
> below patch is appropriate? Thanks!

Sorry for the delay.

If ACPI S4 is supported, /sys/power/disk will list "platform" as one
of the options (and it will be the default one then).  Otherwise,
"platform" is not present in /sys/power/disk, because ACPI is the only
user of hibernation_ops.

HTH
