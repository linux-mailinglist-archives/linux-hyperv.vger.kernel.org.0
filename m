Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5376325E89
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Feb 2021 09:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBZH74 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Feb 2021 02:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBZH7y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Feb 2021 02:59:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B422C061574;
        Thu, 25 Feb 2021 23:59:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614326352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=As1fDYfwKrjxkKoe6zW8X2eDIPaM0LZx7cH6HHLoVWs=;
        b=gbarmf2Qo6ckmhKhSwECGeeDceFfmjCgsZgbKbhtGOe/ZVnrkkWOYHfk9EX/OvaW1rRLNX
        6LDrpfCyyASzExo2fQH3Wk6USh9mNHHsgvWuAZ0ub5xdUjEt5EUT6Vf5DxDGxiufDDA0dD
        kAFR/HOCf19ewbMg3sDq6t6oq6IKm2/gnMZWkiBdDzKAc77Xol8evKFMxq42TLN5Mzy7Uy
        RNyNAhsLGReJ53TJjBHzeNEoYHPjH6oRD0CNEhJq1Rdjk6kLa+SaZ2TLx2X4caPC7LziSo
        LSCkRonnaAQbURvC/8avcnpGuSbPy+eih3OFwIP0fu687A4UJ2O4SpEJooilEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614326352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=As1fDYfwKrjxkKoe6zW8X2eDIPaM0LZx7cH6HHLoVWs=;
        b=oBzcI9hkvNT1WswvpyoaczL8Miw+ylH42+GPWw36ZoSpeUkMPSwywAxm3+Z0cvgGSedn2L
        iPW16K6EswEd9nAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH next v3 12/15] printk: introduce a kmsg_dump iterator
In-Reply-To: <20210225202438.28985-13-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de> <20210225202438.28985-13-john.ogness@linutronix.de>
Date:   Fri, 26 Feb 2021 08:59:10 +0100
Message-ID: <87a6rrxnsh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello,

Thank you kernel test robot!

Despite all of my efforts to carefully construct and test this series,
somehome I managed to miss a compile test with CONFIG_MTD_OOPS. That
kmsg_dumper does require the dumper parameter so that it can use
container_of().

I will discuss this with the printk team. But most likely we will just
re-instate the dumper parameter in the callback.

I apologize for the lack of care on my part.

John Ogness

On 2021-02-26, kernel test robot <lkp@intel.com> wrote:
> Hi John,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on next-20210225]
>
> url:    https://github.com/0day-ci/linux/commits/John-Ogness/printk-remove-logbuf_lock/20210226-043457
> base:    7f206cf3ec2bee4621325cfacb2588e5085c07f5
> config: arm-randconfig-r024-20210225 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a921aaf789912d981cbb2036bdc91ad7289e1523)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/fc7f655cded40fc98ba5304c200e3a01e8291fb4
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review John-Ogness/printk-remove-logbuf_lock/20210226-043457
>         git checkout fc7f655cded40fc98ba5304c200e3a01e8291fb4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/mtd/mtdoops.c:277:45: error: use of undeclared identifier 'dumper'
>            struct mtdoops_context *cxt = container_of(dumper,
>                                                       ^
>>> drivers/mtd/mtdoops.c:277:45: error: use of undeclared identifier 'dumper'
>>> drivers/mtd/mtdoops.c:277:45: error: use of undeclared identifier 'dumper'
>    3 errors generated.
>
>
> vim +/dumper +277 drivers/mtd/mtdoops.c
>
> 4b23aff083649e Richard Purdie 2007-05-29  274  
> fc7f655cded40f John Ogness    2021-02-25  275  static void mtdoops_do_dump(enum kmsg_dump_reason reason)
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  276  {
> 2e386e4bac9055 Simon Kagstrom 2009-11-03 @277  	struct mtdoops_context *cxt = container_of(dumper,
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  278  			struct mtdoops_context, dump);
> fc7f655cded40f John Ogness    2021-02-25  279  	struct kmsg_dump_iter iter;
> fc2d557c74dc58 Seiji Aguchi   2011-01-12  280  
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  281  	/* Only dump oopses if dump_oops is set */
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  282  	if (reason == KMSG_DUMP_OOPS && !dump_oops)
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  283  		return;
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  284  
> fc7f655cded40f John Ogness    2021-02-25  285  	kmsg_dump_rewind(&iter);
> fc7f655cded40f John Ogness    2021-02-25  286  
> df92cad8a03e83 John Ogness    2021-02-25  287  	if (test_and_set_bit(0, &cxt->oops_buf_busy))
> df92cad8a03e83 John Ogness    2021-02-25  288  		return;
> fc7f655cded40f John Ogness    2021-02-25  289  	kmsg_dump_get_buffer(&iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
> e2ae715d66bf4b Kay Sievers    2012-06-15  290  			     record_size - MTDOOPS_HEADER_SIZE, NULL);
> df92cad8a03e83 John Ogness    2021-02-25  291  	clear_bit(0, &cxt->oops_buf_busy);
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  292  
> c1cf1d57d14922 Mark Tomlinson 2020-09-03  293  	if (reason != KMSG_DUMP_OOPS) {
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  294  		/* Panics must be written immediately */
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  295  		mtdoops_write(cxt, 1);
> c1cf1d57d14922 Mark Tomlinson 2020-09-03  296  	} else {
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  297  		/* For other cases, schedule work to write it "nicely" */
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  298  		schedule_work(&cxt->work_write);
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  299  	}
> c1cf1d57d14922 Mark Tomlinson 2020-09-03  300  }
> 4b23aff083649e Richard Purdie 2007-05-29  301  
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
