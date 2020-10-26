Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A1299266
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Oct 2020 17:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776163AbgJZQ30 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Oct 2020 12:29:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38721 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773930AbgJZQ30 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Oct 2020 12:29:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id n18so13354575wrs.5;
        Mon, 26 Oct 2020 09:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWeA8CWri32QkONqVW1NoL41XQcJqip3DA/la05shNE=;
        b=jy3CkCAEDlaxLE0dtPYJlWGZ45KBW7vOvTatZzqoiYYJdDVqHt7UMn4MjQOkKqhUX4
         z4Zkednq+wi5Ny6OB/fg4MXsmNMWWn7rgU8IBpW6TBGE80+1CjyrMFfsKjFiPkA21b+V
         IXP0hNsmNJbWRxsxTPkrP3W2RovMa9+A/UXCA57TdUV0rOeFH3Wpi51/CVVUkEDFi9jD
         kd7IWVTrtTfYAQtRjP0Rc+yhawD9B13YbI/ngwNhZO9P+8TF3pk770cPWH9VFhFThqhE
         4vWuJNBAnEQjJ49E1diK2AEuwWEAZqnE/lAUVPURtn8g20smYwID55Anu7kRNc6gxBkc
         c1Qg==
X-Gm-Message-State: AOAM532DBF+vl57rNrsjLo2h27U7LSKzS36KJHK/IT7d7JIeLfydpzWd
        nlJxn2KTzRBzoE57cIbJv5M=
X-Google-Smtp-Source: ABdhPJz5EooO394mqACvRY2chbha+0h00JUXjmbZ5NmUQw3+2pZDLwSdqyxLZlxLWpcUSNrE8YXzlQ==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr18624693wrt.221.1603729763369;
        Mon, 26 Oct 2020 09:29:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t62sm22130579wmf.22.2020.10.26.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:29:22 -0700 (PDT)
Date:   Mon, 26 Oct 2020 16:29:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, kys@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Clarify comment on x2apic mode
Message-ID: <20201026162921.4kj47twy2wl43jji@liuwe-devbox-debian-v2>
References: <1603723972-81303-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603723972-81303-1-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 26, 2020 at 07:52:52AM -0700, Michael Kelley wrote:
> The comment about Hyper-V accessors is unclear regarding their
> potential use in x2apic mode, as is the associated commit message
> in e211288b72f1.  Clarify that while the architectural and
> synthetic MSRs are equivalent in x2apic mode, the full set of xapic
> accessors cannot be used because of register layout differences.
> 
> Fixes: e211288b72f1 ("x86/hyperv: Make vapic support x2apic mode")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
