Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3A1C0A5D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 00:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3WYF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Apr 2020 18:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgD3WYE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Apr 2020 18:24:04 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94AC1206D9;
        Thu, 30 Apr 2020 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588285444;
        bh=U2wS06jC9o9pM52AkSococGuM+XgTOL9WOXR44wwwmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nB8mUJ6Pr+ljhrNsFLIKSdctC/llz+t2pcx7JDOh0oPr8VKQWeTBxDI7E+xMeStLC
         YJG+PTTpUS++FiCEfMHnakKMR5tEwypkxH9WzJR3NY+WaET9iOTNnwJL1dKYZQ2hQo
         n2b6cYRnfH+6fRINH9l/gw+LAzU9FuEWW69YHNxU=
Date:   Thu, 30 Apr 2020 15:24:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
        Michal Hocko <mhocko@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
Message-Id: <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
In-Reply-To: <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
References: <20200430102908.10107-1-david@redhat.com>
        <20200430102908.10107-3-david@redhat.com>
        <87pnbp2dcz.fsf@x220.int.ebiederm.org>
        <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
        <871ro52ary.fsf@x220.int.ebiederm.org>
        <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
        <875zdg26hp.fsf@x220.int.ebiederm.org>
        <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 30 Apr 2020 20:43:39 +0200 David Hildenbrand <david@redhat.com> wrote:

> > 
> > Why does the firmware map support hotplug entries?
> 
> I assume:
> 
> The firmware memmap was added primarily for x86-64 kexec (and still, is
> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
> get hotplugged on real HW, they get added to e820. Same applies to
> memory added via HyperV balloon (unless memory is unplugged via
> ballooning and you reboot ... the the e820 is changed as well). I assume
> we wanted to be able to reflect that, to make kexec look like a real reboot.
> 
> This worked for a while. Then came dax/kmem. Now comes virtio-mem.
> 
> 
> But I assume only Andrew can enlighten us.
> 
> @Andrew, any guidance here? Should we really add all memory to the
> firmware memmap, even if this contradicts with the existing
> documentation? (especially, if the actual firmware memmap will *not*
> contain that memory after a reboot)

For some reason that patch is misattributed - it was authored by
Shaohui Zheng <shaohui.zheng@intel.com>, who hasn't been heard from in
a decade.  I looked through the email discussion from that time and I'm
not seeing anything useful.  But I wasn't able to locate Dave Hansen's
review comments.


